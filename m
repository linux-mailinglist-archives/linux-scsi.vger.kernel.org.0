Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE738D978
	for <lists+linux-scsi@lfdr.de>; Sun, 23 May 2021 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhEWHlU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 May 2021 03:41:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhEWHlU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 23 May 2021 03:41:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621755592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ror9xItdkp0XCqfJcHlXVMnDoOlzSnn2YexGS/5Nflk=;
        b=qsndOR36E3mAKIh0zZVXbhXmhrVkv6BxkHFQzrrflEpLYcQMs6OQsS/vFgxpQL4hDwHUWk
        ECRlBgBT6XRMJnUn7RGns305z0Ps3o5kUirAfNshYm9CKWOGsm4lLPP04+FM0gz0grVR4H
        Ab+DIYmwLK+RIORqtzy2Bc5mtlHpCIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621755592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ror9xItdkp0XCqfJcHlXVMnDoOlzSnn2YexGS/5Nflk=;
        b=lhWNVsbJaRg0711DH0I4uR81ByGdOHTSbC6S6mmtf0kuGt6xaUin3HUY2OkI6N11IU8UZC
        ojqj5xFNfo80tLAg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD253AC46;
        Sun, 23 May 2021 07:39:52 +0000 (UTC)
Subject: Re: [RFC] virtio_scsi: to poll and kick the virtqueue in timeout
 handler
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, joe.jin@oracle.com,
        junxiao.bi@oracle.com, srinivas.eeda@oracle.com
References: <20210523063843.1177-1-dongli.zhang@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ac161748-15d2-2962-402e-23abca469623@suse.de>
Date:   Sun, 23 May 2021 09:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210523063843.1177-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/23/21 8:38 AM, Dongli Zhang wrote:
> This RFC is to trigger the discussion about to poll and kick the
> virtqueue on purpose in virtio-scsi timeout handler.
> 
> The virtio-scsi relies on the virtio vring shared between VM and host.
> The VM side produces requests to vring and kicks the virtqueue, while the
> host side produces responses to vring and interrupts the VM side.
> 
> By default the virtio-scsi handler depends on the host timeout handler
> by BLK_EH_RESET_TIMER to give host a chance to perform EH.
> 
> However, this is not helpful for the case that the responses are available
> on vring but the notification from host to VM is lost.
> 
How can this happen?
If responses are lost the communication between VM and host is broken, 
and we should rather reset the virtio rings themselves.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
