Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9B404545
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Sep 2021 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350987AbhIIGB3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 02:01:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57332 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350955AbhIIGB2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Sep 2021 02:01:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6FDE21D77;
        Thu,  9 Sep 2021 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631167218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9QpcSoWNbfBgZAsVg1wXH4mwz6iiOGa/E6IWp3n3FY=;
        b=VF1UQ1nTWPCZvi+tuR/palL+9UJEzynxXXXcNIrmDI0/f8onbbhsxI96yTWHaGl6NV6DVj
        /kqsRCvbBQc462mHGDjMeg/Vy5cJo6DtF8VTyw8ZbrIbvnA/EIiBzzwtMEg3aFHJsXnf57
        h6576FbTXIPXAZdywrkuMd/nwNGDxws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631167218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9QpcSoWNbfBgZAsVg1wXH4mwz6iiOGa/E6IWp3n3FY=;
        b=Vw4dR57QZQiapMPsBSa8KvrUWmaPIp7xOcPkF82qlFqTB6JNQ/1IvldLKsxCujqalY2jn1
        qZIuqanhnKJnmaBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BF4D113A61;
        Thu,  9 Sep 2021 06:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mEx6LfKiOWHLVwAAGKfGzw
        (envelope-from <hare@suse.de>); Thu, 09 Sep 2021 06:00:18 +0000
Subject: Re: [PATCH v8 2/5] scsi: sd: add concurrent positioning ranges
 support
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210909023545.1101672-1-damien.lemoal@wdc.com>
 <20210909023545.1101672-3-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e6fb552e-69f7-56ca-24d6-28ebcd2537c6@suse.de>
Date:   Thu, 9 Sep 2021 08:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210909023545.1101672-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/9/21 4:35 AM, Damien Le Moal wrote:
> Add the sd_read_cpr() function to the sd scsi disk driver to discover
> if a device has multiple concurrent positioning ranges (i.e. multiple
> actuators on an HDD). The existence of VPD page B9h indicates if a
> device has multiple concurrent positioning ranges. The page content
> describes each range supported by the device.
> 
> sd_read_cpr() is called from sd_revalidate_disk() and uses the block
> layer functions disk_alloc_independent_access_ranges() and
> disk_set_independent_access_ranges() to represent the set of actuators
> of the device as independent access ranges.
> 
> The format of the Concurrent Positioning Ranges VPD page B9h is defined
> in section 6.6.6 of SBC-5.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/scsi/sd.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/scsi/sd.h |  1 +
>   2 files changed, 82 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
