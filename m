Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEA1FC8D0
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQIeG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 04:34:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:51090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgFQIeG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 04:34:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3DD52AC9F;
        Wed, 17 Jun 2020 08:34:09 +0000 (UTC)
Subject: Re: [PATCH 1/4] gdth: reindent and whitespace cleanup
To:     Daniel Wagner <dwagner@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20200616121821.99113-1-hare@suse.de>
 <20200616121821.99113-2-hare@suse.de>
 <20200617082145.mdsu56bclo3p3dg4@beryllium.lan>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2a7473b3-62af-f7d2-f73a-adcabe21701e@suse.de>
Date:   Wed, 17 Jun 2020 10:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617082145.mdsu56bclo3p3dg4@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/17/20 10:21 AM, Daniel Wagner wrote:
> On Tue, Jun 16, 2020 at 02:18:18PM +0200, Hannes Reinecke wrote:
>> Long overdue. No functional change.
> 
> Did you test if compiler generates the same output? I don't think anyone
> wants to review this patch :)
> 
Hmm. No. Lemme check what happens...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
