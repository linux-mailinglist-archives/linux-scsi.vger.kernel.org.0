Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F5380BFF
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhENOkd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 10:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhENOkc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 May 2021 10:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621003161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kpeo7I8FJibyasj0RNzpRVke+kYRCK3E/UUYHIP14h0=;
        b=IFUl3oQAJ5zyx9TVIm2sISTWtqi2svr82UWJy/cqGp5PuWqjV4VTA8TddFzGkLTbjlxRul
        aKx1dkMqXgKH2JjqOzEs9drRE3akHxsCgx97m3BZSdlvfyDb8tNeWN1Lp4Nl9fgb8Y+6Zx
        35yws7zJSkghubxjS7LOBI1bzl7pcV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-ESzW4xYwN_C4YReusNgoXw-1; Fri, 14 May 2021 10:39:17 -0400
X-MC-Unique: ESzW4xYwN_C4YReusNgoXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B036E8015DB;
        Fri, 14 May 2021 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61AA55D6D1;
        Fri, 14 May 2021 14:39:13 +0000 (UTC)
Subject: Re: [PATCH v5 01/24] mpi3mr: add mpi30 Rev-R headers and Kconfig
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, sathya.prakash@broadcom.com,
        bvanassche@acm.org, hare@suse.de, himanshu.madhani@oracle.com,
        hch@infradead.org
References: <20210513083608.2243297-1-kashyap.desai@broadcom.com>
 <20210513083608.2243297-2-kashyap.desai@broadcom.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <f9fb5ca8-bc32-be52-6f45-54c309c82eac@redhat.com>
Date:   Fri, 14 May 2021 16:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513083608.2243297-2-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/13/21 10:35 AM, Kashyap Desai wrote:
> This adds the Kconfig and mpi30 headers.
> 
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> Cc: sathya.prakash@broadcom.com
> Cc: bvanassche@acm.org
> Cc: thenzl@redhat.com
> Cc: hare@suse.de
> Cc: himanshu.madhani@oracle.com
> Cc: hch@infradead.org

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

