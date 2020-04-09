Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CC1A3A86
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Apr 2020 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDITbl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Apr 2020 15:31:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbgDITbl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Apr 2020 15:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586460701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flaM6tETBTRYGbY133UBzI1wawgUIMyYPEW/Dt3emeE=;
        b=cR721LIbaYgWHEIHfqPUeZ8krjVTR9ytbAVjOcgYfAw3LidzGdVMnxQkSAHFamOvkapix8
        hHBPuyKMv1lSmV8BnJFgoVq1PeOoA9Yq9Y//xHP8VOJe6OqlKiJqCYGeeq2FONkuPntRs6
        6wQYsuD+gepRkUwJq8PFskiyuWPRmO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-xZDAj8DWOo2UcDOl8ynSxA-1; Thu, 09 Apr 2020 15:31:36 -0400
X-MC-Unique: xZDAj8DWOo2UcDOl8ynSxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBE0DBA3;
        Thu,  9 Apr 2020 19:31:35 +0000 (UTC)
Received: from [10.10.116.40] (ovpn-116-40.rdu2.redhat.com [10.10.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89A6299E01;
        Thu,  9 Apr 2020 19:31:34 +0000 (UTC)
Subject: Re: [PATCH 0/2] target: small fixes in pr
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200408132610.14623-1-bstroesser@ts.fujitsu.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E8F7816.4050103@redhat.com>
Date:   Thu, 9 Apr 2020 14:31:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200408132610.14623-1-bstroesser@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 04/08/2020 08:26 AM, Bodo Stroesser wrote:
> This small series is a resend of patches that already were
> sent to target-devel only.
> 
> The patches fix two issues in target core pr handling.
> 

Patches look ok to me and fixes FC for me too.

Reviewed-by: Mike Christie <mchristi@redhat.com>

