import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = [ "tab", "content" ]

  connect() {
    this.showTab(0) // Show the first tab by default
  }

  switchTab(event) {
    let index = this.tabTargets.indexOf(event.currentTarget)
    this.showTab(index)
  }

  showTab(index) {
    console.log(this.contentTargets);
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle('tab-active', i === index)
      if (i === index) {
        tab.classList.add('inline-block', 'p-4', 'text-blue-600', 'rounded-t-lg', 'active', 'dark:text-blue-500', 'dark:border-blue-500');
      } else {
        tab.classList.remove('inline-block', 'p-4', 'text-blue-600', 'rounded-t-lg', 'active', 'dark:text-blue-500', 'dark:border-blue-500');
      }
    });
    this.contentTargets.forEach((content, i) => {
      content.style.display = i === index ? 'grid' : 'none'
    })
  }
}