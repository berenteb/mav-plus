import Foundation
import WebKit
import Combine

/// Protocol for accessing RssRepository
protocol RssProtocol: RequestStatus, Updateable, XMLParserDelegate {
    
    /// Getting singleton instance
    static var shared: RssProtocol {get}
    
    /// The parsed list of RssItems
    var rssItemList: [RssItem] {get}
    
    // TODO
    var publisher: PassthroughSubject<RssFields, Never> { get }
}

/// Enum for the tags to parse
enum InterestingTag: String {
    /// Title of an item
    case title
    
    /// Link to the item
    case link
}

/// Data type for the result of RSS parsing
struct RssFields {
    
    /// The parsed list of RssItems
    var rssItemList: [RssItem]
    
    /// Whether the parsing resulted in an error
    var isError: Bool
    
    /// Whether the parsing is still loading
    var isLoading: Bool
}

/// Class parsing RSS feed
public class RssRepository: NSObject, RssProtocol {
    
    /// Singleton instance
    static var shared = RssRepository() as (any RssProtocol)
    
    /// The parsed list of RssItems
    var rssItemList: [RssItem]
    
    /// Whether the parsing resulted in an error
    var isError: Bool
    
    /// Whether the parsing is still loading
    var isLoading: Bool
    
    /// Last tag visited during parsing
    private var lastTag: String?
    
    /// String accumulating the content of the tags since the last valid tag
    private var lastContent: String?
    
    /// The items parsed so far
    private var parseList: [RssItem]
    
    // TODO
    var publisher = PassthroughSubject<RssFields, Never>()
    
    /// Default initializer, calls self.update()
    public override init() {
        self.rssItemList = []
        self.isError = false
        self.isLoading = true
        self.lastTag = nil
        self.lastContent = nil
        self.parseList = []
        super.init()
        update()
    }
    
    /// Updates self.rssItemList by downloading and parsing the RSS feed again
    public func update() {
        self.isLoading = true
        self.parseList.removeAll()
        
        guard let url: URL = URL(string: RssFeedRequestPath) else {
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                return
            }
            
            if let data = data {
                self.startParsing(inputData: data)
            }
            
            self.isLoading = false
        }
        
        task.resume()
    }
    
    /// Function starting the parsing of the RSS feed
    /// - Parameter inputData: The data received at downloading the RSS feed
    /// - Returns: Nothing
    private func startParsing(inputData: Data?) -> Void {
        if let realInputData: Data = inputData {
            let parser: XMLParser = XMLParser(data: realInputData)
            parser.delegate = self
            
            if (parser.parse()) {
                self.handleNewTag()
                
                DispatchQueue.main.async {
                    if (!self.parseList.isEmpty) {
                        self.rssItemList.removeAll()
                    }
                    
                    self.rssItemList.append(contentsOf: self.parseList)
                    self.publisher.send(RssFields(rssItemList: self.rssItemList, isError: self.isError, isLoading: self.isLoading))
                }
            }
        }
    }
    
    /// Handles a tag in the RSS feed
    /// - Returns: Nothing
    private func handleNewTag() -> Void {
        if let actualTag = self.lastTag, let actualContent = self.lastContent {
            switch actualTag {
            case InterestingTag.title.rawValue:
                self.parseList.append(RssItem(title: actualContent.trimmingCharacters(in: .whitespacesAndNewlines)))
                break
            case InterestingTag.link.rawValue:
                if (!self.parseList.isEmpty) {
                    let localIndex: Int = (self.parseList.count - 1)
                    
                    if (self.parseList.last!.url.isEmpty) {
                        self.parseList[ localIndex ].url = actualContent.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
                
                break
            default:
                break
            }
        }
    }
    
    /// Called during the parsing of the RSS feed, updates self.lastContent
    /// - Parameters:
    ///   - parser: The parser parsing the RSS feed
    ///   - string: The content encountered during parsing
    /// - Returns: Nothing
    public func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) -> Void {
        if (self.lastTag != nil) {
            if let actualContent: String = self.lastContent {
                self.lastContent = actualContent + string
            } else {
                self.lastContent = string
            }
        }
    }
    
    /// Called during the parsing of the RSS feed, at the opening of a new tag
    /// - Parameters:
    ///   - parser: Teh parser parsing the RSS feed
    ///   - elementName: The name of the tag started
    ///   - namespaceURI: URI of the namespace
    ///   - qName: Qualified name
    ///   - attributeDict: Dictionary of the attributes of the tag
    /// - Returns: Nothing
    public func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) -> Void {
        
        self.handleNewTag()
        
        if (elementName == InterestingTag.title.rawValue || elementName == InterestingTag.link.rawValue) {
            self.lastTag = elementName
        } else {
            self.lastTag = nil
        }
        
        self.lastContent = nil
    }
    
    
}

