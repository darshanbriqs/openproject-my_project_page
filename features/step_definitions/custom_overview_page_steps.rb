#-- copyright
# OpenProject My Project Page Plugin
#
# Copyright (C) 2011-2014 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.md for more details.
#++

Given /^I start editing the overview page(?: again)?$/ do
  driver.find_element(:link, "Personalize this page").click
  # ERROR: Caught exception [ERROR: Unsupported command [dragAndDropToObject]]
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
end

Then /^I should be able to change things and see my changes when I finish$/ do
  driver.find_element(:css, "#list-top > #block_workpackagetracking").should be_displayed
  # ERROR: Caught exception [ERROR: Unsupported command [dragAndDropToObject]]
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  driver.find_element(:css, "#list-hidden > #block_members").should be_displayed
  # ERROR: Caught exception [ERROR: Unsupported command [select]]
  driver.find_element(:link, "Add").click
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  (driver.find_elements(:css, "#block-select > option[value='timelog'][disabled]").size).should == 1
  driver.find_element(:css, "#list-hidden > #block_timelog").should be_displayed
  # ERROR: Caught exception [ERROR: Unsupported command [dragAndDropToObject]]
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  driver.find_element(:css, "#list-top > #block_timelog").should be_displayed
  # ERROR: Caught exception [ERROR: Unsupported command [selectWindow]]
  driver.find_element(:css, "#block_wiki > div > a.icon.icon-delete").click
  # ERROR: Caught exception [ERROR: Unsupported command [getConfirmation]]
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  (driver.find_elements(:css, "#block-select > option[value='wiki'][disabled]").size).should == 0
  driver.find_element(:link, "Back").click
  driver.find_element(:css, "#list-top > .widget-box > .issues.overview").should be_displayed
  driver.find_element(:css, "#list-top > .widget-box > .total-hours").should be_displayed
  (driver.find_elements(:css, "#list-left > .widget-box > .wiki").size).should == 0
end

Then /^I should be able to add a teaser element with custom text$/ do
  driver.find_element(:link, "Add").click
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  (driver.find_element(:css, "#list-hidden > #block_a > .handle > #a-preview-div > h2").text).should == "Add teaser ..."
  driver.find_element(:css, "#list-hidden > #block_a > .handle > #a-preview-div").should be_displayed
  driver.find_element(:link, "Edit").click
  driver.find_element(:css, "#list-hidden > #block_a > .handle > #a-form-div").should be_displayed
  driver.find_element(:id, "block_title_a").clear
  driver.find_element(:id, "block_title_a").send_keys "NewTitle"
  driver.find_element(:id, "a-form-submit").click
  (driver.find_element(:css, "#list-hidden > #block_a > .handle > #a-preview-div > h2").text).should == "NewTitle"
  driver.find_element(:link, "Edit").click
  driver.find_element(:id, "textile_a").clear
  driver.find_element(:id, "textile_a").send_keys "NewContent"
  driver.find_element(:link, "Save").click
  (driver.find_element(:css, "#list-hidden > #block_a > .handle > #a-preview-div > p").text).should == "NewContent"
  # ERROR: Caught exception [ERROR: Unsupported command [dragAndDropToObject]]
  !60.times{ break unless (driver.find_element(:css, "#ajax-indicator").displayed? rescue true); sleep 1 }
  driver.find_element(:css, "#list-right > #block_a").should be_displayed
  (driver.find_element(:css, "#list-right > #block_a > .handle > #a-preview-div > p").text).should == "NewContent"
  (driver.find_element(:css, "#list-right > #block_a > .handle > #a-preview-div > h2").text).should == "NewTitle"
  driver.find_element(:link, "Back").click
  (driver.find_element(:css, "#list-right > .widget-box > p").text).should == "NewContent"
end

Then /^I should be able to delete a teaser element$/ do
  driver.find_element(:css, "#block_a > div > a.icon.icon-delete").click
  # ERROR: Caught exception [ERROR: Unsupported command [getConfirmation]]
  driver.find_element(:link, "Back").click
  (driver.find_elements(:css, "#list-right > .widget-box > p").size).should == 0
end
