@Entry
@Component
export default struct History {
    @State history: Array<string> = []


    build() {
      Column() {
        Text("History") {

        }.fontSize(20)
      }
      .padding(20)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }

}