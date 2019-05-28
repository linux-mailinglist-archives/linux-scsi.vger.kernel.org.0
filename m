Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 610532C115
	for <lists+linux-scsi@lfdr.de>; Tue, 28 May 2019 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfE1IU4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 04:20:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfE1IUz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 28 May 2019 04:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D12E5AE24;
        Tue, 28 May 2019 08:20:53 +0000 (UTC)
Date:   Tue, 28 May 2019 10:20:49 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [Patch v2] target/iscsi: fix possible condition with no effect
 (if == else)
Message-ID: <20190528102049.4927905e@suse.de>
In-Reply-To: <20190528012151.GA4845@hari-Inspiron-1545>
References: <20190528012151.GA4845@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 28 May 2019 06:51:52 +0530, Hariprasad Kelam wrote:

> fix below warning reported by coccicheck
> 
> drivers/target/iscsi/iscsi_target_nego.c:175:6-8: WARNING: possible
> condition with no effect (if == else)
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
> Changes in v2: treat SRP as unsupported authtype.
>                Remove unnecessary else
>                return 2 in all unsupported cases

Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David
