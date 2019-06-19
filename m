Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72EE4B620
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfFSKX6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 06:23:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53097 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSKX5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 06:23:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so1134844wms.2
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jun 2019 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H33BTDhT/l9EEeZmnjCEB6vo6nawwms9/xSEDH82HBs=;
        b=Bie5LnlDeeAgAA1nvtvcKs1u1BD3RQqMq8jGDGmwaVac4PnMn4FQeI4x5sn2A5Ax5m
         y+u2OS2D2/R06IDKDURiXIo+8lCUnACiaVhN736Kb0hMPdV1ZAK2p2+ZISCEWIsXgjOM
         7R//c+fKLzmq3QM09n7ifPDfl7NTlPVBq209x3HHKTm8Vgj8Lwd+WzExqTkd8eW6TeSi
         NXiQWm60qpx2Yz+zCI5/Wt/+EqQizKXobcyjqaGE6R1Zb9Jz6E1Y8qiq1dQcbm1vVcZF
         OVSYXzgZKyAmf/VuFztMHvoEJDAXIGcnhOq+uvY7AVwT3QJghAcI2Uw4yFcQXrAtVvk/
         eN7Q==
X-Gm-Message-State: APjAAAXEdPnmkt52qvqoqt+DkaUmlLLEpD87jRw84nabkRB6SP1GgIkU
        QohV+ygNmc6sE2ELuRMqQA70Kg==
X-Google-Smtp-Source: APXvYqxWQbLBxZmTwWS5bJ4BnfJppMsFM1KQRXe6s5uE8Qwm3YgP31SQhddztiaw5e1msir7HRMGrQ==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr7718728wme.102.1560939835412;
        Wed, 19 Jun 2019 03:23:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d? ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
        by smtp.gmail.com with ESMTPSA id o185sm1198768wmo.45.2019.06.19.03.23.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:23:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] scsi: virtio_scsi: remove unused 'affinity_hint_set'
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
References: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c111c5a3-1602-e935-300d-d75e14fe2bd9@redhat.com>
Date:   Wed, 19 Jun 2019 12:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 19/06/19 09:52, Dongli Zhang wrote:
> The 'affinity_hint_set' is not used any longer since
> commit 0d9f0a52c8b9 ("virtio_scsi: use virtio IRQ affinity").
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/scsi/virtio_scsi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 13f1b3b..1705398 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -74,9 +74,6 @@ struct virtio_scsi {
>  
>  	u32 num_queues;
>  
> -	/* If the affinity hint is set for virtqueues */
> -	bool affinity_hint_set;
> -
>  	struct hlist_node node;
>  
>  	/* Protected by event_vq lock */
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
