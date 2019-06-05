Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6036046
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfFEP1S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 11:27:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfFEP1R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 11:27:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so15032728pfe.6
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 08:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zir2taRi1fNzW6S3iQbJK7wWtLDWBptDJMni0oEtP/M=;
        b=ch6kn9QXVAKi9kW2jPh1ijEEHUe//b2VsYINe1AzGlRz+rNYCqmRvR+EAteN3/gl1f
         IFVblEknarxMVP+xZxyOUbsxmui8h8v0/YoN5Ut8yS9f2UM9Hgusr4z4kP179IwVaWGR
         JN7l0OP8gbYPaPyMnAO250IRhiTAQTfOI686AguSWGbjkzVXPjNbrQ3oHs1PrvZa7+v+
         NOvSvcRV10DYPaokSSJPmcM7MuBm18pCtMnY8XsheNQSLDQAoSKnBryb8FTWj8fpHTIW
         dGO+QLw3JDOyoQ7Uv7RwejZ4FjEzqNd2iEBY9FmQEZDMq3sM/5obNWPvEgxbnMLVVBC4
         EyPw==
X-Gm-Message-State: APjAAAX35PGRkO6S4z/5rTvAodugpYIFtm49XRNb5RrhIpf3mYsTsw5d
        mhiuMIhV9sfk48mCs81r0g0YVUCw
X-Google-Smtp-Source: APXvYqz6AXMv6by8snqJLu4dyusylJM1w/QbWBp6XByOaFVHolyXu/PpDOnu6X7t0IdevZslFLrjBw==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr5209567pgl.316.1559748437063;
        Wed, 05 Jun 2019 08:27:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h2sm10673948pgs.17.2019.06.05.08.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:27:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] libfc: kill lld_event_callback
To:     Hannes Reinecke <hare@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190605073942.125577-1-hare@suse.de>
 <20190605073942.125577-2-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7d43e9fc-fcde-4a8f-96b8-ed1a81c9c28a@acm.org>
Date:   Wed, 5 Jun 2019 08:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605073942.125577-2-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/5/19 12:39 AM, Hannes Reinecke wrote:
> It will only ever be set so another callback, and the pointer to
> this callback is available on all locations. So kill it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>   drivers/scsi/libfc/fc_rport.c | 13 ++++++-------
>   include/scsi/libfc.h          |  3 ---
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
> index 0da34c7a6866..255e6568be66 100644
> --- a/drivers/scsi/libfc/fc_rport.c
> +++ b/drivers/scsi/libfc/fc_rport.c
> @@ -155,10 +155,9 @@ struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
>   	rdata->maxframe_size = FC_MIN_MAX_PAYLOAD;
>   	INIT_DELAYED_WORK(&rdata->retry_work, fc_rport_timeout);
>   	INIT_WORK(&rdata->event_work, fc_rport_work);
> -	if (port_id != FC_FID_DIR_SERV) {
> -		rdata->lld_event_callback = lport->tt.rport_event_callback;
> +	if (port_id != FC_FID_DIR_SERV)
>   		list_add_rcu(&rdata->peers, &lport->disc.rports);
> -	}
> +
>   	return rdata;
>   }
>   EXPORT_SYMBOL(fc_rport_create);
> @@ -308,9 +307,9 @@ static void fc_rport_work(struct work_struct *work)
>   			FC_RPORT_DBG(rdata, "callback ev %d\n", event);
>   			rport_ops->event_callback(lport, rdata, event);
>   		}
> -		if (rdata->lld_event_callback) {
> +		if (lport->tt.rport_event_callback) {
>   			FC_RPORT_DBG(rdata, "lld callback ev %d\n", event);
> -			rdata->lld_event_callback(lport, rdata, event);
> +			lport->tt.rport_event_callback(lport, rdata, event);
>   		}
>   		kref_put(&rdata->kref, fc_rport_destroy);
>   		break;
> @@ -334,9 +333,9 @@ static void fc_rport_work(struct work_struct *work)
>   			FC_RPORT_DBG(rdata, "callback ev %d\n", event);
>   			rport_ops->event_callback(lport, rdata, event);
>   		}
> -		if (rdata->lld_event_callback) {
> +		if (lport->tt.rport_event_callback) {
>   			FC_RPORT_DBG(rdata, "lld callback ev %d\n", event);
> -			rdata->lld_event_callback(lport, rdata, event);
> +			lport->tt.rport_event_callback(lport, rdata, event);
>   		}
>   		if (cancel_delayed_work_sync(&rdata->retry_work))
>   			kref_put(&rdata->kref, fc_rport_destroy);
> diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
> index 76cb9192319a..2c3c5b9e7cc6 100644
> --- a/include/scsi/libfc.h
> +++ b/include/scsi/libfc.h
> @@ -212,9 +212,6 @@ struct fc_rport_priv {
>   	struct rcu_head		    rcu;
>   	u16			    sp_features;
>   	u8			    spp_type;
> -	void			    (*lld_event_callback)(struct fc_lport *,
> -						      struct fc_rport_priv *,
> -						      enum fc_rport_event);
>   };

Before this patch lport->tt.rport_event_callback was not called for 
ports of type FC_FID_DIR_SERV. This patch causes that callback function 
also to be called for ports of type FC_FID_DIR_SERV. Is that change 
acceptable? If so, please mention this in the commit message.

Thanks,

Bart.
