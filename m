Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A085936B609
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhDZPps (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 11:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZPpq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:45:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06EDEABD0;
        Mon, 26 Apr 2021 15:45:04 +0000 (UTC)
Subject: Re: [PATCH 19/39] qlogicfas408: make ql_pcmd() a void function
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
References: <20210423113944.42672-1-hare@suse.de>
 <20210423113944.42672-20-hare@suse.de> <20210426152619.GK25615@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <eccd1f5d-c60e-afd2-21d1-84b22b9f4c5b@suse.de>
Date:   Mon, 26 Apr 2021 17:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210426152619.GK25615@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/26/21 5:26 PM, Christoph Hellwig wrote:
> On Fri, Apr 23, 2021 at 01:39:24PM +0200, Hannes Reinecke wrote:
>> Make ql_pcmd() a void function and set the SCSI result directly.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/scsi/qlogicfas408.c | 75 ++++++++++++++++++++++++-------------
>>  1 file changed, 49 insertions(+), 26 deletions(-)
> 
> Can you explain why this is useful?  Because it does not really look
> like it cleans up anything as-is.
> 
Hmm. I needed it for the entire patchset (splitting up host_byte and
status_byte in two distinct values), but it might well be pointless here.
Will be checking it and dropping if not required.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
