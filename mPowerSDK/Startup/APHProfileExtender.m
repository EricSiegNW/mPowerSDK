// 
//  APHProfileExtender.m 
//  mPower 
// 
// Copyright (c) 2015, Sage Bionetworks. All rights reserved. 
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
// 
// 2.  Redistributions in binary form must reproduce the above copyright notice, 
// this list of conditions and the following disclaimer in the documentation and/or 
// other materials provided with the distribution. 
// 
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors 
// may be used to endorse or promote products derived from this software without 
// specific prior written permission. No license is granted to the trademarks of 
// the copyright holders even if such marks are included in this software. 
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE 
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
// 
 
#import "APHProfileExtender.h"
#import "APHLocalization.h"

// ***************************************************************************
// ***************************************************************************
// Of Note: This class is not adding extra sections as of mPower 1.1 because no
// special options were still required. In order to add special sections, set the
// kDefaultNumberOfExtraSections to the # required and adjust the decorateCell
// and didSelectorRowAtIndexPath delegate methods to reflect the new section(s)
// desired.
// Also, consider setting kDefaultNumberOfExtraSections to the # of sections
// desired + 1 if nonzero in order to add an empty row to provide an empty
// row at the bottom and keep the layout looking uniform.
// ***************************************************************************
// ***************************************************************************

static  NSInteger  kDefaultNumberOfExtraSections =  1;
static  CGFloat    kDefaultHeightForExtraRows    = 64.0;

@interface APHProfileExtender ()
@property BOOL isEditing;
@end

@implementation APHProfileExtender

- (UIViewController *)copyrightInfoViewController
{
    // Default implementation - Private App implementation should use category override
    return [UIViewController new];
}

#pragma mark - APCProfileViewControllerDelegate

- (BOOL)willDisplayCell:(NSIndexPath *) __unused indexPath {
    return YES;
}

    //
    //    return  kDefaultNumberOfExtraSections  extra sections for a nicer layout in profile
    //
    //    return  0  to turn off the feature in the profile View Controller
    //
- (NSInteger)numberOfSectionsInTableView:(UITableView *) __unused tableView
{
    return  kDefaultNumberOfExtraSections;
}

    //
    //    Add to the number of rows
    //
- (NSInteger) tableView:(UITableView *) __unused tableView numberOfRowsInAdjustedSection:(NSInteger)section
{
    NSInteger count = 0;
    
    if (section == 0) {
        count = 1;
    }
    
    return count;
}

- (UITableViewCell *)decorateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)__unused indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = NSLocalizedStringWithDefaultValue(@"APH_COPYRIGHT_INFO_TITLE", nil, APHLocaleBundle(), @"Copyright Information", @"Title for copyright information.");
    cell.detailTextLabel.text = @"";
    cell.selectionStyle = self.isEditing ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtAdjustedIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = tableView.rowHeight;
    
    if (indexPath.section == 0) {
        height = kDefaultHeightForExtraRows;
    }
    
    return height;
}

    //
    //    provide a sub-class of UIViewController to do the work
    //
    //        you can either push the controller or present it depending on your preferences
    //
- (void)navigationController:(UINavigationController *)navigationController didSelectRowAtIndexPath:(NSIndexPath *) __unused indexPath
{
    if (!self.isEditing) {
        UIViewController *controller = [self copyrightInfoViewController];
        
        controller.navigationController.navigationBar.topItem.title = NSLocalizedStringWithDefaultValue(@"APH_COPYRIGHT_INFO_TITLE", nil, APHLocaleBundle(), @"Copyright Information", @"Title for copyright information.");
        controller.hidesBottomBarWhenPushed = YES;
        
        [navigationController pushViewController:controller animated:YES];
    }
}

- (void)hasStartedEditing {
    self.isEditing = YES;
}

- (void)hasFinishedEditing {
    self.isEditing = NO;
}

@end
