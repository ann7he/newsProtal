import router from '@ohos.router'

@Entry
@Component
struct Login {
  @State message: string = '欢迎注册'

  build() {
    Stack() {
      Row() {
        Column() {
          Image($r("app.media.icon"))
            .width(100)
            .margin(60)
          Text(this.message)
            .fontSize(24)
            .fontWeight(500)
            .margin(30)
          Row() {
            Text("账号 | ")
              .margin(10)
            TextInput({ placeholder: "请输入账号" })
              .width(140)
              .backgroundColor(Color.White)
              .placeholderFont({ size: 12 })
          }
          .width(200)
          .height(40)
          .border({ width: 1, color: Color.Black })
          .borderRadius(10)
          .margin({ bottom: 15 })

          Row() {
            Text("密码 | ")
              .margin(10)
            TextInput({ placeholder: "请输入密码" })
              .width(140)
              .backgroundColor(Color.White)
              .placeholderFont({ size: 12 })
          }
          .width(200)
          .height(40)
          .border({ width: 1, color: Color.Black })
          .borderRadius(10)
          .margin({ bottom: 15 })

          Button("注   册", { type: ButtonType.Normal, stateEffect: true })
            .width(200)
            .height(40)
            .borderRadius(10)
            .margin({ bottom: 15 })
            .onClick(() => {
              router.pushUrl({ url: "pages/login" })
            })
          Button("取   消", { type: ButtonType.Normal, stateEffect: true })
            .width(200)
            .height(40)
            .borderRadius(10)
            .onClick(() => {
              router.pushUrl({ url: "pages/login" })
            })
        }
        .width('100%')
      }
      .height('100%')
    }
  }
}
