import router from '@ohos.router'
import http from '@ohos.net.http'
import { MainMenu } from './MainMenu'
import hilog from '@ohos.hilog'

@Entry
@Component
struct Login {
  @State message: string = '欢迎登录'
  @Provide menuCurrentIndex: number = 1
  @State handLePop: boolean = false

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

          Button("登     录", { type: ButtonType.Normal, stateEffect: true })
            .width(200)
            .height(40)
            .borderRadius(10)
            .margin({ bottom: 15 })
            .onClick(() => {
              router.pushUrl({ url: "pages/NewsList" })
            })
          Button("注     册", { type: ButtonType.Normal, stateEffect: true })
            .width(200)
            .height(40)
            .borderRadius(10)
            .onClick(() => {
              router.pushUrl({ url: "pages/Register" })
            })
        }
        .width('100%')
      }
      .height('100%')

      //输入菜单
      MainMenu()
    }
  }

  Login() {
    let httpRequest = http.createHttp()
    // 订阅返回信息
    httpRequest.on("headersReceive", (header) => {
      hilog.info(0x0000, "testTag", '%{public}s', JSON.stringify(header))
    })
    //发送http请求
    httpRequest.request(
      "http://172.19.15.104:8848/test/json/login.json",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-type': 'application/json'
        },
        // post请求发送参数
        extraData: {}
      },
      (err, data) => {
        if (!err) {
          let result = data.result.toString()
          hilog.info(0x0000, "testTage", "%{public}s", result)
          result = JSON.parse(result)
          if (result["code"] == 1) {
            router.pushUrl({ url: "pages/NewsList" })
          } else {
            this.message = "登录失败"
            this.handLePop = true
          }
        }
      }
    )
  }
}
