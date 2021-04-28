Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEF36D449
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Apr 2021 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhD1Iyy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Apr 2021 04:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232153AbhD1Iyx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Apr 2021 04:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E39EAFC1;
        Wed, 28 Apr 2021 08:54:07 +0000 (UTC)
Subject: Re: [PATCH v8 04/31] elx: libefc_sli: queue create/destroy/parse
 routines
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20210423233455.27243-1-jsmart2021@gmail.com>
 <20210423233455.27243-5-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <330e8f5e-ee33-2e24-9c62-f34e4523cc4e@suse.de>
Date:   Wed, 28 Apr 2021 10:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423233455.27243-5-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/24/21 1:34 AM, James Smart wrote:
> This patch continues the libefc_sli SLI-4 library population.
> 
> This patch adds service routines to create mailbox commands
> and adds APIs to create/destroy/parse SLI-4 EQ, CQ, RQ and MQ queues.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/scsi/elx/include/efc_common.h |   16 +
>  drivers/scsi/elx/libefc_sli/sli4.c    | 1347 +++++++++++++++++++++++++
>  drivers/scsi/elx/libefc_sli/sli4.h    |    9 +
>  3 files changed, 1372 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
