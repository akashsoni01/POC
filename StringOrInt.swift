enum StringOrInt: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Name"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


/*
## how to use StringOrInt
 problem - you are returning a key that have two type of value string and int in api resonse
 so define that key with StringOrInt and create a extension like that to use it in your Channge yourVarname and YourJsonCodableModelName.


 
 extension YourJsonCodableModelName{
     var yourVarName:Int?{
         var yourVarName = 0
         if let yourVarName = reference_user_id{
             switch yourVarName{
             case let .integer(value):
                 refrenceUserId = value
             case let .string(value):
                 refrenceUserId = Int(value) ?? 0

             }
         }else{
    return nil
 }
         return refrenceUserId
     }
 }

 */
