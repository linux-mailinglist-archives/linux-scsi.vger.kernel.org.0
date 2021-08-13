Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1883EBA17
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhHMQb4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Aug 2021 12:31:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbhHMQbz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Aug 2021 12:31:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01C891FFDC;
        Fri, 13 Aug 2021 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628872288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IIpDXLEWEav3fvx0zIsV+OGfhOmQluu3CqQ1kjOqeY=;
        b=ayIXpkBcDa8+p5qSEagjW5CEZFQncy1ZYR+9kg6aDonbK1Hn6U9BQCYF9HgHXi6q0woGCP
        7h2DLeB3ZSxEhUzmusH7a2HCpKR89ADC0R+zVnjRKW4j4CCuiU/ebq5wLMVdrG7lzwi7Pz
        PoYD6oJYlVI8uHk54ShW7bQrYtI8tkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628872288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IIpDXLEWEav3fvx0zIsV+OGfhOmQluu3CqQ1kjOqeY=;
        b=5rNcdCYAxeE0wjkqfh/4UZZwdDvnrnB+vFgOVQhUzc70JN3+DHdtuWB1vLFZmSx584QWs1
        qq7NNui08sz8+0CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A642E137C3;
        Fri, 13 Aug 2021 16:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EUWrJ1+eFmEOIgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 13 Aug 2021 16:31:27 +0000
Subject: Re: [PATCH 3/3] scsi: Remove scsi_cmnd.tag
To:     John Garry <john.garry@huawei.com>, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, bvanassche@acm.org
References: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
 <1628862553-179450-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <079f2fcf-c466-679c-7153-1127fbd8bda5@suse.de>
Date:   Fri, 13 Aug 2021 18:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628862553-179450-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/13/21 3:49 PM, John Garry wrote:
> It is never read, so get rid of it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_lib.c  | 1 -
>   include/scsi/scsi_cmnd.h | 1 -
>   2 files changed, 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
