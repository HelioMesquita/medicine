import Foundation

struct Medicine: Decodable {
	let name: String
	let available: Int
	let links: Links
}
