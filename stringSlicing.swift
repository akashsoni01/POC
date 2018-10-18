// code for slicing the token into key and iv
func getKeyAndIv(from token:String) -> (String,String){
    let  indexOfFirst16 = token.index(token.startIndex, offsetBy: 15)
    let indexOfLast16 = token.index(token.startIndex, offsetBy: token.count - 16)
    let key = ""+token[...indexOfFirst16]
    let iv = ""+token[indexOfLast16...]
    return (key,iv)
}
