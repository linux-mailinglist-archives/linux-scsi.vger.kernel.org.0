Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09336D492
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Apr 2021 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhD1JMW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Apr 2021 05:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1JMR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 28 Apr 2021 05:12:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D6A7AFE6;
        Wed, 28 Apr 2021 09:11:32 +0000 (UTC)
Subject: Re: [PATCH v8 12/31] elx: libefc: Remote node state machine
 interfaces
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Ram Vegesna <ram.vegesna@broadcom.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20210423233455.27243-1-jsmart2021@gmail.com>
 <20210423233455.27243-13-jsmart2021@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <f076db24-9cf3-ab1f-9623-96b171af1822@suse.de>
Date:   Wed, 28 Apr 2021 11:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423233455.27243-13-jsmart2021@gmail.com>
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
> - Remote node (aka remote port) allocation, initializaion and
>   destroy routines.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
