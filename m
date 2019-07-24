Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695D572734
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 07:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfGXFMZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 01:12:25 -0400
Received: from smtp.infotech.no ([82.134.31.41]:44313 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfGXFMY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Jul 2019 01:12:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 6D5202041D7;
        Wed, 24 Jul 2019 07:12:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TUYlchUgrTzz; Wed, 24 Jul 2019 07:12:17 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 8E574204165;
        Wed, 24 Jul 2019 07:12:16 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 14/19] sg: tag and more_async
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-15-dgilbert@interlog.com>
 <201907240216.Rf4loWXG%lkp@intel.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <07f02e56-c6f4-7483-ddd9-4b91450c7625@interlog.com>
Date:   Wed, 24 Jul 2019 01:12:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907240216.Rf4loWXG%lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-07-23 2:11 p.m., kbuild test robot wrote:
> Hi Douglas,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mkp-scsi/for-next]
> [also build test WARNING on v5.3-rc1 next-20190723]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Hi,
Well yes, you seem to be using the wrong git tree, or at least the
wrong patchset. From the subject line above, I match that with a
patchset sent to the linux-scsi list on 20190524. It contained both
a rework of the existing driver plus new features outlined here:
   http://sg.danny.cz/sg/sg_v40.html

It was suggested that I break that patchset in two, the first one
being the existing driver rework. That patchset was sent to the
linux-scsi list on 20190616 commencing with this subject line:
"[PATCH 00/18] sg: add v4 interface". To date I have had no feedback
for the later patchset so I have no idea whether the kbuild test
robot has checked it or not. It is curious why yesterday, 6 weeks
after the second patchset, robot messages start reappearing on a
superseded patchset sent two months ago. The reported problems
have already been dealt with (i.e. fixed).

Work (mainly testing) continues on the "new features" patchset which
I have structured on top of the "add v4 interface" patchset as patches
19 through 34. I see no point in sending a follow-on patchset with
new features until the patchset sent on 20190616 is accepted.

Doug Gilbert

