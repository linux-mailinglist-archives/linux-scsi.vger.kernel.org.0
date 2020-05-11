Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C11CD1B6
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2020 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEKGNz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 May 2020 02:13:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKGNz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 May 2020 02:13:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68714ACFE;
        Mon, 11 May 2020 06:13:56 +0000 (UTC)
Subject: Re: [PATCH 09/15] target: drop sess_get_initiator_sid from PR code
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-10-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f25ddc37-71dc-0bd7-e33e-e9ca54a1b342@suse.de>
Date:   Mon, 11 May 2020 08:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-10-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> Use the transport id session id in the PR related code.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   drivers/target/target_core_pr.c        | 23 ++++-------------------
>   drivers/target/target_core_transport.c | 11 ++++-------
>   2 files changed, 8 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
