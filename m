Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB42A759
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfEYXPp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 May 2019 19:15:45 -0400
Received: from smtp.infotech.no ([82.134.31.41]:60885 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfEYXPp (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 25 May 2019 19:15:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2D4A4204165;
        Sun, 26 May 2019 01:15:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jndFZ9i7Tlec; Sun, 26 May 2019 01:15:36 +0200 (CEST)
Received: from [172.20.2.178] (unknown [12.158.45.77])
        by smtp.infotech.no (Postfix) with ESMTPA id 0589820414F;
        Sun, 26 May 2019 01:15:34 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 05/19] sg: replace rq array with lists
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-6-dgilbert@interlog.com>
 <201905251706.XN3uQInU%lkp@intel.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <2b9a7bc3-28d2-60dc-afdb-721cba0c98f0@interlog.com>
Date:   Sat, 25 May 2019 19:15:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905251706.XN3uQInU%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-05-25 5:33 a.m., kbuild test robot wrote:
> Hi Douglas,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mkp-scsi/for-next]
> [also build test WARNING on next-20190524]
> [cannot apply to v5.2-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Douglas-Gilbert/sg-v4-interface-rq-sharing-multiple-rqs/20190525-161346
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 7.4.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.4.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/scsi/sg.c: In function 'sg_ioctl':
>>> drivers/scsi/sg.c:1698:1: warning: the frame size of 5824 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>      }
>      ^

Hi Robot,
That seems a surprisingly large stack size for that architecture. When
I do:
   make checkstack drivers/scsi/sg.o

there are over 200 other "stack hogs" larger than sg_ioctl() which clocks
in at 536 bytes ***. The is on x86_64 (i5-7200U) architecture. Even the
winners on my list are comfortably under 2048 bytes:

0xffffffff81052c11 sha1_transform_avx2 [vmlinux]:       1376
0xffffffff81054a83 _end [vmlinux]:                      1376
0x00000dd1 test_queue [usbtest]:                        1224
0x00001321 test_queue [usbtest]:                        1224
0x0000aa79 ipmi_panic_request_and_wait [ipmi_msghandler]:1088
0xffffffff8121378f do_sys_poll [vmlinux]:               992
0xffffffff81213ca8 do_sys_poll [vmlinux]:               992
....

I could trim some more bytes (e.g. the SG_LOG() macro does a stack allocation
of 160 bytes, probably 100 would be enough) but that won't bring the
reported 5824 byte stack usage anywhere near the safe range.

Doug Gilbert

*** and sg_ioctl() is the biggest sg driver stack hog on my list, followed
     by sg_read at 368 bytes.
