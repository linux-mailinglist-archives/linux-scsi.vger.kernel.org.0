Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8D75537
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfGYRRe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jul 2019 13:17:34 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36971 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGYRRe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Jul 2019 13:17:34 -0400
Received: by mail-wm1-f51.google.com with SMTP id f17so45407688wme.2
        for <linux-scsi@vger.kernel.org>; Thu, 25 Jul 2019 10:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GI7TypPZrCo2YjoDnbCGAb1GMDPGFKEKLj12E8wiAzs=;
        b=s8IDF8pNcjA1XSwfbFhmdkPTsxF+HsBpWA/oJDzR1tPTJ0owMevL7tuV9f6Mf91ln5
         qkyqW/S2kqk+d00ivY+BN1uWK/rTyIsP0O1AGR9NCW/KPGO5h/xP7mNyY9+pvZ1lSq9m
         SNdjf+U7sm9HEAzVGAAXiELCeVLuWWeu0jVxrDxz20FeSt+uY3QhLjWV40vyVJ4yLSPS
         +0RAtLKB0adG6k0kvh6nPkFf4fH3C0/gWpO5FuEk0khIRDi8uMH/a66ZoLp9uO8RRIOw
         tvYUMTINhPm4+9Q7hi0Axakm4a9l7/UlF4tBbCfwmS75DhEZN7dow5JI8sLt5bCDlo0B
         yrkw==
X-Gm-Message-State: APjAAAW+yjn9SLd4k38tEp8w0yXLkb+dRg9NItSr4A+WQHdVZrmwf5lW
        OiMRVwRTo7KlRuEKdVGWA/kXNg==
X-Google-Smtp-Source: APXvYqxGRGX1U/7RcaGo2/tr7qTx7IDfw/mkUTXYzlzHYP2Y99C1CNXbkLcB+gF7ZGTYlGQXAgCbsA==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr83523473wmi.0.1564075051919;
        Thu, 25 Jul 2019 10:17:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id s2sm40187684wmj.33.2019.07.25.10.17.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:17:31 -0700 (PDT)
Subject: Re: SCSI batching since next-20190723 seems to fail multipath table
 creation?
To:     Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
References: <3d70ae2c-10f0-a346-0cae-e0ece7215616@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <94b20458-8839-ebd5-74cf-e523bdd6606a@redhat.com>
Date:   Thu, 25 Jul 2019 19:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d70ae2c-10f0-a346-0cae-e0ece7215616@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 25/07/19 19:02, Steffen Maier wrote:
> 
> 9e5470fe2d61 ("scsi: virtio_scsi: implement request batching")
> 8930a6c20791 ("scsi: core: add support for request batching")
> 
> REBOOT into kernel with above commits reverted and now multipath
> assembly works again:

Can you try applying only this from these two commits:

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 601b9f1de267..eb4e67d02bfe 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1673,10 +1673,11 @@  static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		blk_mq_start_request(req);
 	}
 
+	cmd->flags &= SCMD_PRESERVED_FLAGS;
 	if (sdev->simple_tags)
 		cmd->flags |= SCMD_TAGGED;
-	else
-		cmd->flags &= ~SCMD_TAGGED;
+	if (bd->last)
+		cmd->flags |= SCMD_LAST;
 
 	scsi_init_cmd_errh(cmd);
 	cmd->scsi_done = scsi_mq_done;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 76ed5e4acd38..91bd749a02f7 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -57,6 +57,7 @@  struct scsi_pointer {
 #define SCMD_TAGGED		(1 << 0)
 #define SCMD_UNCHECKED_ISA_DMA	(1 << 1)
 #define SCMD_INITIALIZED	(1 << 2)
+#define SCMD_LAST		(1 << 3)
 /* flags preserved across unprep / reprep */
 #define SCMD_PRESERVED_FLAGS	(SCMD_UNCHECKED_ISA_DMA | SCMD_INITIALIZED)
 

?  These should be the only changes visible to the zfcp driver.

Thanks,

Paolo
