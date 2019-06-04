Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996E83434B
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfFDJgs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 05:36:48 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:37464 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJgs (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Tue, 4 Jun 2019 05:36:48 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 04 Jun 2019 11:36:46 +0200
Subject: Re: [PATCH 01/24] block: disable elevator for reserved tags
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-2-hare@suse.de> <20190604081430.GA16717@lst.de>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <bb4a749a-da2b-94bc-f7f1-6ba5d9ea53b5@suse.com>
Date:   Tue, 4 Jun 2019 11:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604081430.GA16717@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/4/19 10:14 AM, Christoph Hellwig wrote:
> On Wed, May 29, 2019 at 03:28:38PM +0200, Hannes Reinecke wrote:
>> Reserved requests are internal to the driver and we wouldn't know
>> if and how they should be merged.
>> So disable the elevator for reserved tags.
> 
> Internal request better be REQ_OP_DRV* pass through requests,
> for which we never merge anyway.  So this patch doesn't look like
> it actually is needed.
> 
Okay, will be dropping it for the next iteration.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
