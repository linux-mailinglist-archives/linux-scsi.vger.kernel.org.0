Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDF3609A9
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Apr 2021 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDOMoU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Apr 2021 08:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhDOMoT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 15 Apr 2021 08:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618490635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eRw4tzyjMP4mOAObLJaWnz3Glgd7mZP5G3nx2D5b28=;
        b=BRbcUWJ6uYb3QGvt6kLvOvPsTCVNAAEQcSYX4NPL4eutW/McFCcVmJ2i2BLOPim29k8YKJ
        a702SzLAPfEzHPTDe0KVzOrpE4v0ddMqP8st9ZvXgVyGtPpNRxnjYHVLLjFSwqCj+ifngJ
        FUNh+Pie4kmSkVkmB47q+mCs/TVrkvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-LjAlMbkDM7G2LLyQGuDL7w-1; Thu, 15 Apr 2021 08:43:54 -0400
X-MC-Unique: LjAlMbkDM7G2LLyQGuDL7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4541B18BE5;
        Thu, 15 Apr 2021 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B515C3FD;
        Thu, 15 Apr 2021 12:43:47 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] mpi3mr: print pending host ios for debug
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     sathya.prakash@broadcom.com
References: <20210407020451.924822-1-kashyap.desai@broadcom.com>
 <20210407020451.924822-20-kashyap.desai@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <0202c01c-f8f4-d175-ee51-b9db36f5bc48@redhat.com>
Date:   Thu, 15 Apr 2021 14:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407020451.924822-20-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/7/21 4:04 AM, Kashyap Desai wrote:
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: sathya.prakash@broadcom.com

Looks good



Reviewed-by: Tomas Henzl <thenzl@redhat.com>

