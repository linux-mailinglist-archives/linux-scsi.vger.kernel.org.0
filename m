Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7E2E345
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2ReP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 13:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfE2ReO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 13:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8388AD02;
        Wed, 29 May 2019 17:34:13 +0000 (UTC)
Subject: Re: [PATCH 05/24] scsi: add scsi_cmd_from_priv()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-6-hare@suse.de>
 <cf6017bd-fc02-8b61-c703-aec24916ae63@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9ebd2f4b-2627-e8f8-0e4a-8e25be59ab32@suse.de>
Date:   Wed, 29 May 2019 19:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf6017bd-fc02-8b61-c703-aec24916ae63@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 5:14 PM, Bart Van Assche wrote:
> On 5/29/19 6:28 AM, Hannes Reinecke wrote:
>> Add a command to retrieve the scsi_cmnd structure from the driver
>          ^^^^^^^
>          function?
>> private allocation data.
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
