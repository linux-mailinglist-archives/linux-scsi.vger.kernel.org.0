Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D673BC9FD
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Jul 2021 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhGFKfM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Jul 2021 06:35:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKfI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Jul 2021 06:35:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A2D4226DF;
        Tue,  6 Jul 2021 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625567549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYa45f4FhhRp+3FK6NuiOaD625cS0Uqo4Ax5m9HnxYw=;
        b=NRj74pTdCy5DxHYIxwbfnLobgD/j6f23HzVf1OS9cvWIpyYUH8n+sd/dgaOSLmFDrHpQwW
        ntq1sDwz1GcrYxQPfeX1lejGBgKrhFPt/zH+Y9WApyi1yPwV8pPTrRHWhe6gW3wFhzk2lU
        RxnD8JjhQBW5aXrxZEc7cyAOxaw7AlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625567549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYa45f4FhhRp+3FK6NuiOaD625cS0Uqo4Ax5m9HnxYw=;
        b=+GzqWh4ZemorKBDqD5TsMk/iO0aFymDwcLq1fcK+Fv9dr8pvI2650ZYx/AMlfgFtXRywqv
        9NhBrXf50dxV8kCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1A6351372D;
        Tue,  6 Jul 2021 10:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3XK7Az0x5GAKZQAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 06 Jul 2021 10:32:29 +0000
Subject: Re: [PATCH V2 3/6] scsi: add flag of .use_managed_irq to 'struct
 Scsi_Host'
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-4-ming.lei@redhat.com>
 <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com> <YOLXJZF7wo/IiFMU@T590>
 <20210706053719.GA17027@lst.de> <YOQJD2dgeb8wobOk@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fb71bccf-0d92-68ed-ad42-cac23fede5a8@suse.de>
Date:   Tue, 6 Jul 2021 12:32:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOQJD2dgeb8wobOk@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/6/21 9:41 AM, Ming Lei wrote:
> On Tue, Jul 06, 2021 at 07:37:19AM +0200, Christoph Hellwig wrote:
>> On Mon, Jul 05, 2021 at 05:55:49PM +0800, Ming Lei wrote:
>>> The thing is that blk_mq_pci_map_queues() is allowed to be called for
>>> non-managed irqs. Also some managed irq consumers don't use blk_mq_pci_map_queues().
>>>
>>> So this way just provides hint about managed irq uses, but we really
>>> need to get this flag set if driver uses managed irq.
>>
>> blk_mq_pci_map_queues is absolutely intended to only be used by
>> managed irqs.  I wonder if we can enforce that somehow?
> 
> It may break some scsi drivers.
> 
> And blk_mq_pci_map_queues() just calls pci_irq_get_affinity() to
> retrieve the irq's affinity, and the irq can be one non-managed irq,
> which affinity is set via either irq_set_affinity_hint() from kernel
> or /proc/irq/.
> 
But that's static, right? IE blk_mq_pci_map_queues() will be called once 
during module init; so what happens if the user changes the mapping 
later on? How will that be transferred to the driver?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
