import preferences from '@ohos.data.preferences';
import dataPreferences from '@ohos.data.preferences';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';

export class CommentDao extends UIAbility {
  /**
   * 通过新闻id存储 评论草稿
   * @param id 新闻id
   * @param value 草稿内容
   */
  put(id, value) {
    //获取当前页面
    try {
      dataPreferences.getPreferences(this.context, 'mystore', (err, preferences) => {
        if (err) {
          hilog.error(0x000000, "test-Tag", '%{public}s', `preferences获取失败. 错误码:${err.code},错误信息:${err.message}`);
          return;
        }
        hilog.info(0x000000, "test-Tag", '%{public}s', 'preferences获取成功');
        // 进行相关数据操作
        try {
          preferences.put('comment_' + id, value, (err) => {
            if (err) {
              hilog.error(0x000000, "test-Tag", '%{public}s', `put失败. 错误码:${err.code},错误信息:${err.message}`);
              return;
            }
            hilog.info(0x000000, "test-Tag", '%{public}s', 'put成功')
          })
        } catch (err) {
          hilog.error(0x000000, "test-Tag", '%{public}s', `put异常. 错误码:${err.code},错误信息:${err.message}`);
        }

      })
    } catch (err) {
      hilog.error(0x000000, "test-Tag", '%{public}s', `preferences获取异常. 错误码:${err.code},错误信息:${err.message}`);
    }
  }

  getById(id, callback) {
    //获取当前页面
    try {
      dataPreferences.getPreferences(this.context, 'mystore', (err, preferences) => {
        if (err) {
          hilog.error(0x000000, "test-Tag", '%{public}s', `preferences获取失败. 错误码:${err.code},错误信息:${err.message}`);
          return;
        }
        hilog.info(0x000000, "test-Tag", '%{public}s', 'preferences获取成功');
        // 进行相关数据操作
        try {
          preferences.get('comment_' + id, '', callback)
        } catch (err) {
          hilog.error(0x000000, "test-Tag", '%{public}s', `get获取异常. 错误码:${err.code},错误信息:${err.message}`);
        }
      })
    } catch (err) {
      hilog.error(0x000000, "test-Tag", '%{public}s', `preferences获取异常. 错误码:${err.code},错误信息:${err.message}`);
    }
  }
}