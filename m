Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7B36D49B
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Apr 2021 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhD1JOh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Apr 2021 05:14:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:52304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1JOh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Apr 2021 05:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DAB5AFC1;
        Wed, 28 Apr 2021 09:13:52 +0000 (UTC)
Subject: Re: [PATCH v8 15/31] elx: libefc: Extended link Service IO handling
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20210423233455.27243-1-jsmart2021@gmail.com>
 <20210423233455.27243-16-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <8f8ce1b9-4c70-da83-3a41-c434b108689c@suse.de>
Date:   Wed, 28 Apr 2021 11:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423233455.27243-16-jsmart2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/24/21 1:34 AM, James Smart wrote:
> This patch continues the libefc library population.
> 
> This patch adds library interface definitions for:
> Functions to build and send ELS/CT/BLS commands and responses.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/scsi/elx/libefc/efc_els.c | 1099 +++++++++++++++++++++++++++++
>  drivers/scsi/elx/libefc/efc_els.h |  107 +++
>  2 files changed, 1206 insertions(+)
>  create mode 100644 drivers/scsi/elx/libefc/efc_els.c
>  create mode 100644 drivers/scsi/elx/libefc/efc_els.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
