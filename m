Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA9E289F
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Oct 2019 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408284AbfJXDHR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Oct 2019 23:07:17 -0400
Received: from smtp.infotech.no ([82.134.31.41]:53533 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405098AbfJXDHR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Oct 2019 23:07:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7AB6F204197;
        Thu, 24 Oct 2019 05:07:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r3rklMY41RzO; Thu, 24 Oct 2019 05:07:09 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 2D8BA20415B;
        Thu, 24 Oct 2019 05:07:08 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 16/23] sg: rework sg_vma_fault
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20191008075022.30055-1-dgilbert@interlog.com>
 <20191008075022.30055-17-dgilbert@interlog.com>
 <b42ad2fd-4908-2397-1e74-7243dc70c26f@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <b8c9b511-5fa8-0add-cd8a-a7db67b347c4@interlog.com>
Date:   Wed, 23 Oct 2019 23:07:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b42ad2fd-4908-2397-1e74-7243dc70c26f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-10-18 6:17 a.m., Hannes Reinecke wrote:
> On 10/8/19 9:50 AM, Douglas Gilbert wrote:
>> Simple refactoring of the sg_vma_fault() function.
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> ---
>>   drivers/scsi/sg.c | 33 +++++++++++++++++++++++----------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>> index 903faafaeff9..befcbfbcece1 100644
>> --- a/drivers/scsi/sg.c
>> +++ b/drivers/scsi/sg.c
>> @@ -1389,14 +1389,16 @@ sg_fasync(int fd, struct file *filp, int mode)
>>   	return fasync_helper(fd, filp, mode, &sfp->async_qp);
>>   }
>>   
>> +/* Note: the error return: VM_FAULT_SIGBUS causes a "bus error" */
>>   static vm_fault_t
>>   sg_vma_fault(struct vm_fault *vmf)
>>   {
>> -	struct vm_area_struct *vma = vmf->vma;
>> -	struct sg_fd *sfp;
>> +	int k, length;
>>   	unsigned long offset, len, sa;
>> +	struct vm_area_struct *vma = vmf->vma;
>>   	struct sg_scatter_hold *rsv_schp;
>> -	int k, length;
>> +	struct sg_device *sdp;
>> +	struct sg_fd *sfp;
>>   	const char *nbp = "==NULL, bad";
>>   
>>   	if (!vma) {
> Of course, one would prefer normal kernel-doc style for the comment ...

For static functions, that is left up to the discretion of the maintainer,
according to the document to which you refer :-)

I prefer comments that aren't compilable, IOWs that don't state the
bleeding obvious. While I was debugging sg_vma_fault() it took me a
while to understand why my test harness was crashing, hence that
comment.

Doug Gilbert

sg_vma_fault(
> Otherwise:
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> 
> Cheers,
> 
> Hannes
> 

