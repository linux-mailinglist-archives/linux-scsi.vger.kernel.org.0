Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E01CD1A5
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2020 08:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEKGKN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 May 2020 02:10:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgEKGKN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 May 2020 02:10:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A5D0AC6D;
        Mon, 11 May 2020 06:10:14 +0000 (UTC)
Subject: Re: [PATCH 04/15] tcm loop: use target_parse_emulated_name
To:     Mike Christie <mchristi@redhat.com>, bvanassche@acm.org,
        bstroesser@ts.fujitsu.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200510215744.21999-1-mchristi@redhat.com>
 <20200510215744.21999-5-mchristi@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ccaceea3-23fa-3fc3-e41b-72032e61c135@suse.de>
Date:   Mon, 11 May 2020 08:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510215744.21999-5-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/10/20 11:57 PM, Mike Christie wrote:
> Use target_parse_emulated_name so the acl and SCSI names are properly
> formatted.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>   drivers/target/loopback/tcm_loop.c | 65 ++++++--------------------------------
>   1 file changed, 10 insertions(+), 55 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
