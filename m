Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4D324C0
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jun 2019 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfFBUYL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 2 Jun 2019 16:24:11 -0400
Received: from smtp.infotech.no ([82.134.31.41]:42543 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfFBUYK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 2 Jun 2019 16:24:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0475F2041CF;
        Sun,  2 Jun 2019 22:24:09 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Biqa+OrVis1d; Sun,  2 Jun 2019 22:24:03 +0200 (CEST)
Received: from [172.20.1.42] (96-80-82-153-static.hfc.comcastbusiness.net [96.80.82.153])
        by smtp.infotech.no (Postfix) with ESMTPA id 8313C204155;
        Sun,  2 Jun 2019 22:24:00 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <a1096ff2-71f5-f398-6173-c8832ac7e26c@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <1c706e3c-6195-a84b-ac70-f15e5e55e9a7@interlog.com>
Date:   Sun, 2 Jun 2019 16:23:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a1096ff2-71f5-f398-6173-c8832ac7e26c@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-05-26 11:49 a.m., Bart Van Assche wrote:
> On 5/24/19 11:47 AM, Douglas Gilbert wrote:
>> This patchset restores some functionality that was in the v2 driver
>> version and has been broken by some external patch in the interim
>> period (20 years).
> 
> What is an "external patch"?

It's a patch made by someone with a first name like Christoph, Jens or
James (picking some names at random) that is applied whether or not
the maintainer of said driver approves ("ack's) or not.

IMO The maintainer should be able to restore features removed in this
fashion (I'm talking specifically about the neutering of
SG_FLAG_NO_DXFER) without review as it is in the documented interface.
Plus I know of at least one power user who was peeved to find out that
it was quietly broken.

Doug Gilbert


P.S the use case is mirrored disks: reading one disk for the actual data,
and the other disk to check if there is an IO error. So the second disk
doesn't need its data transferred to the user space (thus saving time).

