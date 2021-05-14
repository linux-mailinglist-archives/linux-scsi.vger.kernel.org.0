Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E270380C1A
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhENOpJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 10:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231473AbhENOpJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 May 2021 10:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621003437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFJWsRP304KW9koB0KesVbDRqWl1hdLRszOG0uxPfMA=;
        b=h7K0VNFsOCflt9Ws5CAiIo0nkGVazkQi+RTiIXx466ArujSFKyHu8STbhvkty6qYBsrfq1
        XaIs/ZbwxVPJwuSwpvYtKhc7ZtqeSRSliAr+h0Dc12mvdKPe6UQUsP2TP5kIIPFRc6kK8K
        tRWnfmMNtwb6s4YeqQLDZtKB0ohGAcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-128I4ZwWMdmo3P_qTiTuMw-1; Fri, 14 May 2021 10:43:55 -0400
X-MC-Unique: 128I4ZwWMdmo3P_qTiTuMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45386801B20;
        Fri, 14 May 2021 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38CEC1971B;
        Fri, 14 May 2021 14:43:52 +0000 (UTC)
Subject: Re: [PATCH v5 02/24] mpi3mr: base driver code
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com,
        bvanassche@acm.org, hare@suse.de, himanshu.madhani@oracle.com
References: <20210513083608.2243297-1-kashyap.desai@broadcom.com>
 <20210513083608.2243297-3-kashyap.desai@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <21d7b35e-75bd-929b-d8b1-caaf7c0bc800@redhat.com>
Date:   Fri, 14 May 2021 16:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513083608.2243297-3-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/13/21 10:35 AM, Kashyap Desai wrote:
> This patch covers basic pci device driver requirements -
> device probe, memory allocation, mapping system registers,
> allocate irq lines etc.
> 
> Source is managed in mainly three different files.
> 
> mpi3mr_fw.c -	Keep common code which interact with underlying fw/hw.
> mpi3mr_os.c -	Keep common code which interact with scsi midlayer.
> mpi3mr_app.c -	Keep common code which interact with application/ioctl.
> 		This is currently work in progress.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: sathya.prakash@broadcom.com
> Cc: bvanassche@acm.org
> Cc: hare@suse.de
> Cc: thenzl@redhat.com
> Cc: himanshu.madhani@oracle.com

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

