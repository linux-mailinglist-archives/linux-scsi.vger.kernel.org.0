Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A31C3283
	for <lists+linux-scsi@lfdr.de>; Mon,  4 May 2020 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEDGQR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 May 2020 02:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgEDGQQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 May 2020 02:16:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CBB3DABBD;
        Mon,  4 May 2020 06:16:16 +0000 (UTC)
Subject: Re: [PATCH RFC v3 00/41] scsi: enable reserved commands for LLDDs
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
References: <20200430131904.5847-1-hare@suse.de>
 <20200501174647.GD23795@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fb91390c-04db-f711-c39f-681f28ba20bb@suse.de>
Date:   Mon, 4 May 2020 08:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501174647.GD23795@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/1/20 7:46 PM, Christoph Hellwig wrote:
> Can we get the basic infrastructure sorted out with just say csiostor
> and virtio-scsi before we get into all the more complicated bits?
> A 40+ series gets close to impossible to review unless it is just
> all mechnical changes.
> 
Sure. This patchset was just an RFC to show where I would want to go.
I'll be restricting it to the virtio and csiostor for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
