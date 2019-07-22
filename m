Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53015708E5
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfGVSvF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 14:51:05 -0400
Received: from smtp.infotech.no ([82.134.31.41]:39216 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfGVSvF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Jul 2019 14:51:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2B93420423A;
        Mon, 22 Jul 2019 20:51:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vCLaqz3Gx9SH; Mon, 22 Jul 2019 20:50:55 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id D2FE220417A;
        Mon, 22 Jul 2019 20:50:53 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 2/3] fcoe: avoid memset across pointer boundaries
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190722062231.115865-1-hare@suse.de>
 <20190722062231.115865-3-hare@suse.de> <20190722115013.GC32052@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <4c448b5f-2db5-7732-3659-3e4915c94c29@interlog.com>
Date:   Mon, 22 Jul 2019 14:50:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722115013.GC32052@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-07-22 7:50 a.m., Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 08:22:30AM +0200, Hannes Reinecke wrote:
>> Gcc-9 complains for a memset across pointer boundaries, which happens
>> as the code tries to allocate a flexible array on the stack.
>> Turns out we cannot do this without relying on gcc-isms, so
>> with this patch we'll embed the fc_rport_priv structure into
>> fcoe_rport, can use the normal 'container_of' outcast, and
>> will only have to do a memset over one structure.
> 
> This looks mostly good, but:
> 
> I think the subject and changelog are a bit odd.  What you do here
> is to change that way how the private data is allocated by embeddeding
> the fc_rport_priv structure into the private data, so that should be
> the focus of the description.  That this was triggered by the memset
> warning might be worth mentioning, but probably only after explaining
> what you did.
> 
>> @@ -2738,10 +2736,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
>>   {
>>   	struct fip_header *fiph;
>>   	enum fip_vn2vn_subcode sub;
>> -	struct {
>> -		struct fc_rport_priv rdata;
>> -		struct fcoe_rport frport;
>> -	} buf;
>> +	struct fcoe_rport buf;
> 
> Wouldn't rport or frport be a better name for this variable?
> 
>>   	fiph = (struct fip_header *)skb->data;
>> @@ -2757,7 +2752,8 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
>>   		goto drop;
>>   	}
>>   
>> -	rc = fcoe_ctlr_vn_parse(fip, skb, &buf.rdata);
>> +	memset(&buf, 0, sizeof(buf));
> 
> Instead of the memset you could do an initialization at declaration
> time:
> 
> 	struct fcoe_rport rport = { };

https://en.cppreference.com/w/c/language/struct_initialization

"When initializing an object of struct or union type, the initializer must
be a non-empty, brace-enclosed, comma-separated list of initializers for
the members:"

Hmmm, "non-empty", is that a GNU extension?

However it is good C++11, so if that is where we a moving, great.

Doug Gilbert

>> -	struct {
>> -		struct fc_rport_priv rdata;
>> -		struct fcoe_rport frport;
>> -	} buf;
>> +	struct fcoe_rport buf;
>>   	int rc;
>>   
>>   	fiph = (struct fip_header *)skb->data;
>>   	sub = fiph->fip_subcode;
>> -	rc = fcoe_ctlr_vlan_parse(fip, skb, &buf.rdata);
>> +	memset(&buf, 0, sizeof(buf));
> 
> Same two comments apply here.
> 

