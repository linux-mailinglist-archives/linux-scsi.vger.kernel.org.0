Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528D44851A
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQORU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 10:17:20 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55022 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQORU (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Mon, 17 Jun 2019 10:17:20 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 17 Jun 2019 16:17:18 +0200
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
To:     James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-2-bvanassche@acm.org>
 <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
 <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
 <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com> <yq1tvd1lgql.fsf@oracle.com>
 <d7d48fc4-9df6-74d1-f308-bf5a9d8ef0a7@broadcom.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <4f86591c-4460-0200-a912-e6f26e436f9c@suse.com>
Date:   Mon, 17 Jun 2019 16:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d7d48fc4-9df6-74d1-f308-bf5a9d8ef0a7@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/7/19 5:46 PM, James Smart wrote:
> On 6/7/2019 5:30 AM, Martin K. Petersen wrote:
>> Hannes,
>>
>>> So let's restrict userspace to only ever setting 'RUNNING' or
>>> 'OFFLINE'.  None of the other states make sense to set from userspace.
>> Yes, please!
>>
> 
> +1 for me too
> 
Ok, will be drafting up a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
