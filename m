Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7F3422CD
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Mar 2021 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCSRFx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Mar 2021 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSRFh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 19 Mar 2021 13:05:37 -0400
X-Greylist: delayed 3022 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 10:05:36 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA843C06174A
        for <linux-scsi@vger.kernel.org>; Fri, 19 Mar 2021 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HyvzuApyZWWhqjrNFY29O48nFedCXNhIeOGcu6efov0=; b=oYvXx86zoiu3IvY4xgqCI2jac4
        VUXa5TIfW+iJsVpVeFM6m5SYPFTRTF0hJaqLgoyVGVmmdC3RA6jdIAcKv5WREE2jrkf99+l0kn2Vs
        9I8+VZ1S4IMGrr6s9rXiulNh153XQJKvexu8DWbe57j/0RKbN8ndAbpx8Gv+WxyPeLTEyU7zVCT7/
        YGljORLLnQZM3kZrqqstM0qXvr2GDalnvsDHJd9yFQru4Z3ZjkuRCsbbFzqqM4vPqeslgdp+sutdc
        lL5dDSh22JhNeYxohVDy/uWOEWWFQAXKh9fdjolyzdCkSikYItJCGUOnRQXAADzpAPOQkU8Yapu26
        OpKNE/Ag==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNHmF-001Nji-I3; Fri, 19 Mar 2021 16:15:08 +0000
Date:   Fri, 19 Mar 2021 09:15:07 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        lee.jones@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: Fix a typo
In-Reply-To: <20210319092311.31776-1-unixbhaskar@gmail.com>
Message-ID: <efdb99f1-9035-ce8e-ec8c-a2d7684772af@bombadil.infradead.org>
References: <20210319092311.31776-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_091507_616239_AE091AE0 
X-CRM114-Status: GOOD (  13.26  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/boudaries/boundaries/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/boudaries/boundaries/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> drivers/scsi/csiostor/csio_hw_t5.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/csiostor/csio_hw_t5.c b/drivers/scsi/csiostor/csio_hw_t5.c
> index 1df8891d3725..86fded97d799 100644
> --- a/drivers/scsi/csiostor/csio_hw_t5.c
> +++ b/drivers/scsi/csiostor/csio_hw_t5.c
> @@ -244,7 +244,7 @@ csio_t5_edc_read(struct csio_hw *hw, int idx, uint32_t addr, __be32 *data,
>  *
>  * Reads/writes an [almost] arbitrary memory region in the firmware: the
>  * firmware memory address, length and host buffer must be aligned on
> - * 32-bit boudaries.  The memory is transferred as a raw byte sequence
> + * 32-bit boundaries.  The memory is transferred as a raw byte sequence
>  * from/to the firmware's memory.  If this memory contains data
>  * structures which contain multi-byte integers, it's the callers
>  * responsibility to perform appropriate byte order conversions.
> --
> 2.26.2
>
>
