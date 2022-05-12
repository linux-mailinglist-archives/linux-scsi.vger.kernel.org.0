Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0355524970
	for <lists+linux-scsi@lfdr.de>; Thu, 12 May 2022 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbiELJvh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 May 2022 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351894AbiELJvc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 May 2022 05:51:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25583C4A2
        for <linux-scsi@vger.kernel.org>; Thu, 12 May 2022 02:51:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9242F21CCD;
        Thu, 12 May 2022 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652349087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awl23rnaPshiQJCRT1fEhOTKhFkxc13B2kBpdyfx1J4=;
        b=FXYz3YhVQhpt4do3XwTHKHjFCjXPEVY2sqKIGYcWVSlKRHA2rU6rPX1MrpEOmswVcMyCWl
        CNgIX4axfCqz0Awl4Z3oi0omyy/AT+JMHoCe1fukDrfFBEKuRGN0WxO/fkiTTKajXNGJMj
        w26YwDNBHsUnHEg5f6Zpxvp0GN2GB5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652349087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awl23rnaPshiQJCRT1fEhOTKhFkxc13B2kBpdyfx1J4=;
        b=TjB6SaIXzB3V1ltvoBxqQZq5Ap+VClFlR1sbfQuDrhv+nz4uhWQV0r9I646nfwA3pTpUwx
        v2YMZcnb7R0NMPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73B7413A84;
        Thu, 12 May 2022 09:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +oHSGZ/YfGK2PwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 09:51:27 +0000
Message-ID: <a444684f-9d78-7422-6f9b-c988d2f8244b@suse.de>
Date:   Thu, 12 May 2022 11:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] lpfc: Add support for vmid tagging of NVMe I/Os
Content-Language: en-US
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
 <20220510200028.37399-5-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220510200028.37399-5-jsmart2021@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/10/22 22:00, James Smart wrote:
> Modify the nvme io path to look for vmid support and call the
> transport to obtain the io's appid value.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 45 +++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
