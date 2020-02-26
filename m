Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B52170B8D
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 23:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgBZW0q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 17:26:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgBZW0q (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 17:26:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D134AE84;
        Wed, 26 Feb 2020 22:26:43 +0000 (UTC)
Subject: Re: [PATCH 02/13] scsi: add scsi_host_complete_all_commands() helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20200213140422.128382-1-hare@suse.de>
 <20200213140422.128382-3-hare@suse.de> <20200226173952.GA23141@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ed5f8bad-3029-6dff-23e4-4103a267f91b@suse.de>
Date:   Wed, 26 Feb 2020 23:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226173952.GA23141@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/26/20 6:39 PM, Christoph Hellwig wrote:
> On Thu, Feb 13, 2020 at 03:04:11PM +0100, Hannes Reinecke wrote:
>>   extern void scsi_host_put(struct Scsi_Host *t);
>>   extern struct Scsi_Host *scsi_host_lookup(unsigned short);
>>   extern const char *scsi_host_state_name(enum scsi_host_state);
>> +extern void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status);
> 
> This adds an > 80 char line.  And externs on function declarations in
> headers are never needed anyway.
> 
Ok, will be cleaning it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
