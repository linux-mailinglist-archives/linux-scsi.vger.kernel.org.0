Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23113BBE6
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfFJSkt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 14:40:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57270 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387398AbfFJSks (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 14:40:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 111C28EE182;
        Mon, 10 Jun 2019 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560192048;
        bh=usNEm2Gqi+2+vSE4LshXaDu4tT1APcrE5ZhceIGsPIs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AMn8GHNp9i/MnPLXDBtGBRgxPh3u2yzkgroQSi95WKtQEEGX1n0ysxy9mR4uGT7Xq
         sWl9A5bgB1AIgCFu/Na8nTWsdupL16O5rkoiv47bDGOakaW1iRYpobXoamaRCuqegn
         pNICbYgGSF6E5BVl/nem4Dmxqzr/669HihDh73t4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zdxky-sAhqp0; Mon, 10 Jun 2019 11:40:47 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 55C578EE105;
        Mon, 10 Jun 2019 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560192047;
        bh=usNEm2Gqi+2+vSE4LshXaDu4tT1APcrE5ZhceIGsPIs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AKWJvT4lGKSf47NCNA5npfrUqvLGjcCbEHE/9xGpJHKFJyisOt7BwNSlZPwW3X6gi
         qw8buB6hK8WpjM123iV4wZsH67uUROspf91TWYD8JkLpVCWuHuXZE2WMwXlKCAqRgn
         qwUF8ZYoBVjDM+oDJo5Fnbm8R1FdiIiyu1/TTBdE=
Message-ID: <1560192046.3698.11.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5] scsi: vmw_pscsi: use sgl helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 11:40:46 -0700
In-Reply-To: <20190610150317.29546-2-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sgl helper to
> operate sgl.

This also isn't a chained driver.  However, this driver seems to
achieve this by magic number matching, which looks unsafe.  I'd really
prefer it if vmw_pvscsi.h had

#define PVSCSI_MAX_NUM_SG_ENTRIES_PER_SEGMENT SG_ALL

James

