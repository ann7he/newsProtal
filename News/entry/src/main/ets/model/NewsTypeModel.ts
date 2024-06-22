import { NewsType } from '../model/NewsType';
import http from '@ohos.net.http';

class NewsTypeModel {
  baseURL: string = 'http://localhost:8081'
  page: number = 1

  getNewsType(id: number | string): Promise<NewsType[]> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      const url = `${this.baseURL}/newstypes/${id}`;

      httpRequest.request(url, {
        method: http.RequestMethod.GET,
      })
        .then((resp) => {
          if (resp.responseCode === 200) {
            try {
              const result = JSON.parse(resp.result.toString());
              resolve(result);
            } catch (parseError) {
              reject('解析响应数据失败');
            }
          } else {
            reject(`请求失败，状态码：${resp.responseCode}`);
          }
        })
        .catch((error) => {
          reject(`网络请求失败: ${error.message}`);
        })
        .finally(() => {
          // 可选：释放资源或关闭连接等操作
          httpRequest.destroy();
        });
    });
  }
}

const newsTypeModel = new NewsTypeModel();

export default newsTypeModel;