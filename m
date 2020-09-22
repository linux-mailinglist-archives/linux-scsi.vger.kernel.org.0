Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD82427383E
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 03:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIVB6w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 21:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgIVB6w (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 21:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600739931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zreSqKSTNRDAh7fOPqLlhi7nKX6J3ywk4wzexdlKViI=;
        b=EdavBrbb+ocot1jmWMMXBUWvbfYjIsep7PkjFS/z+KneBeMD3wkaR+k3SdAGxv1pVomiKv
        B3PJeZtgtlnhb0vSUvbvW6E+V73Zuq0oNiEdM9rZGtYT7APWPKjLTmTkYGJq2kKwNJET0G
        xsOg2YEOU5CdFdabC6hGNoIlcUegNdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-pnhuC_u2Pzum7jft6brYzw-1; Mon, 21 Sep 2020 21:58:49 -0400
X-MC-Unique: pnhuC_u2Pzum7jft6brYzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C3DF1868402;
        Tue, 22 Sep 2020 01:58:48 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85187366D;
        Tue, 22 Sep 2020 01:58:39 +0000 (UTC)
Subject: Re: [PATCH 1/8] vhost vdpa: fix vhost_vdpa_open error handling
To:     Mike Christie <michael.christie@oracle.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-2-git-send-email-michael.christie@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e857cdd5-f1f6-0227-282d-3d4e690a60d6@redhat.com>
Date:   Tue, 22 Sep 2020 09:58:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600712588-9514-2-git-send-email-michael.christie@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


On 2020/9/22 上午2:23, Mike Christie wrote:
> We must free the vqs array in the open failure path, because
> vhost_vdpa_release will not be called.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/vhost/vdpa.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 3fab94f..3301214 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -808,6 +808,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>   
>   err_init_iotlb:
>   	vhost_dev_cleanup(&v->vdev);
> +	kfree(vqs);
>   err:
>   	atomic_dec(&v->opened);
>   	return r;


Acked-by: Jason Wang <jasowang@redhat.com>

