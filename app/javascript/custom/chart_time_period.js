document.addEventListener('turbo:load', function () {
  window.selectTimePeriod = function (select) {
    var selectedValue = select.value;
    if (selectedValue === 'week') {
      document.getElementById('week_chart').style.display = 'block';
      document.getElementById('month_chart').style.display = 'none';
    } else if (selectedValue === 'month') {
      document.getElementById('week_chart').style.display = 'none';
      document.getElementById('month_chart').style.display = 'block';
    }
  };
});
