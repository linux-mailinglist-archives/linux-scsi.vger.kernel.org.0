Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0D30226B
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbhAYHam (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Jan 2021 02:30:42 -0500
Received: from comms.puri.sm ([159.203.221.185]:35316 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbhAYHaK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Jan 2021 02:30:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D1702E0FDE;
        Sun, 24 Jan 2021 23:29:25 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y5yLFPTCRWy6; Sun, 24 Jan 2021 23:29:24 -0800 (PST)
Subject: Re: [PATCH] scsi_logging: print cdb into new line after opcode
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Ewan D. Milne" <emilne@redhat.com>
Cc:     jejb@linux.ibm.com, dgilbert@interlog.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122083918.901-1-martin.kepplinger@puri.sm>
 <c0c7b4cde76c9b15aad9fa213dcaeb75295763fd.camel@redhat.com>
 <yq1mtx09wpa.fsf@ca-mkp.ca.oracle.com>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <efab85a2-d22c-b9cb-d001-cbe09063ba5e@puri.sm>
Date:   Mon, 25 Jan 2021 08:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <yq1mtx09wpa.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23.01.21 04:09, Martin K. Petersen wrote:
> 
> Ewan,
> 
>>> sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 60 40 00 00 01
>>> 00
>>>
>>> Print the cdb into a new line in any case, not only when cmd_len is
>>> greater than 16. The above example error will then read:
>>>
>>> sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28
>>> 28 00 01 c0 09 00 00 00 08 00
>>
>> I'd rather we not change this.
> 
> I agree. While the current format is suboptimal, there are lots of
> things out there parsing these error messages.
> 

hi Ewan, hi Martin,

That's totally fine. I had this on my list since Douglas suggested to 
change this during a discussion back in july and I basically wanted to 
get opinions:
https://lore.kernel.org/linux-scsi/31f1ec62-7047-a34b-fdcb-5ea2a2104292@interlog.com/

thanks,
                                  martin
