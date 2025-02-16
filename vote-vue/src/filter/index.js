import Vue from 'vue'
// import moment from 'moment'

import { format } from 'date-fns'

// 自定义过滤器
Vue.filter('date-format', function (value, formatStr = 'yyyy-MM-yy HH:mm:ss') {
 return format(value,formatStr)
})

Vue.filter('fmtDate',
function renderTime(date) {
  var dateee = new Date(date).toJSON();
  return new Date(+new Date(dateee) + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
}
)
