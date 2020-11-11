Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF32AF56C
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Nov 2020 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgKKPsu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Nov 2020 10:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbgKKPst (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Nov 2020 10:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605109728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ve3o5+sQEc7bSeoJK6A9FCOfDF3MDLOEkdQyVi3FknE=;
        b=bjM1SGulNi+bOn5N/FPSbo2429MVobbP/FaGE9u1lmNgIsv2sGOEZ5TltFEX2akylcnbEG
        b6H16Yk2/CBM0k6puSkCC+C3+573UcbzEg6DZ1L04/QwY0yGfMlISUVw5cvIwejY19j/7V
        e5POFn8TYW7RkF6jZHUmj2FAqTaBaGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-FtJohrB8NX-b56Qo5frC-g-1; Wed, 11 Nov 2020 10:48:44 -0500
X-MC-Unique: FtJohrB8NX-b56Qo5frC-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 023EECEC64;
        Wed, 11 Nov 2020 15:48:43 +0000 (UTC)
Received: from [10.35.206.45] (unknown [10.35.206.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DCD773675;
        Wed, 11 Nov 2020 15:48:40 +0000 (UTC)
Subject: Re: [PATCH 2/2] target: iscsi: fix a race condition when aborting a
 task
To:     Michael Christie <michael.christie@oracle.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        bvanassche@acm.org, m.lombardi85@gmail.com
References: <20201007145326.56850-1-mlombard@redhat.com>
 <20201007145326.56850-3-mlombard@redhat.com>
 <20daa17d-08e7-a412-4d33-bcf75587eca6@oracle.com>
 <1852a8bd-3edc-5c49-fa51-9afe52f125a8@redhat.com>
 <184667b1-032b-c36f-d1e7-5cfef961c763@oracle.com>
 <71691FED-C164-482C-B629-A8B89B81E566@oracle.com>
 <a936cc4e-1610-5201-5960-107689b81820@redhat.com>
 <68e77a2c-c868-669f-0c4f-0a5bb0259249@oracle.com>
 <5111dcb0-ef0d-fc11-ee1a-ae2a9b30150a@redhat.com>
 <5D26782D-1249-4A2C-8BF9-7176D5B85F55@oracle.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <4268d61b-89f2-ce74-200b-d5fc21a207bd@redhat.com>
Date:   Wed, 11 Nov 2020 16:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5D26782D-1249-4A2C-8BF9-7176D5B85F55@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dne 11. 11. 20 v 16:37 Michael Christie napsal(a):
> If the SCSI R/W has the CMD_T_ABORTED bit set, we move it it back to the conn_cmd_list and the abort code path cleans it up. But then we still have the ABORT’s se_cmd on the tmp_list. We will then call 
> 
> transport_generic_free_cmd(wait_for_tasks=true) -> __transport_wait_for_tasks(fabric_stop=true)
> 
> And wait for the ABORT to complete, and the ABORT does not complete until the last ref on the command it’s aborting completes.


Right. now I understand it.
Thanks.

Maurizio

