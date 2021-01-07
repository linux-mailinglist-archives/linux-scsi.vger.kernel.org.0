Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6812ECC45
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhAGJEo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 04:04:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbhAGJEn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 04:04:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AC24ACAF;
        Thu,  7 Jan 2021 09:04:02 +0000 (UTC)
Date:   Thu, 7 Jan 2021 10:04:01 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 19/31] elx: efct: Hardware queues creation and deletion
Message-ID: <20210107090401.ph5hv2a4ckunugvs@beryllium.lan>
References: <20210107005030.2929-1-jsmart2021@gmail.com>
 <20210107005030.2929-20-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107005030.2929-20-jsmart2021@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jan 06, 2021 at 04:50:18PM -0800, James Smart wrote:
> This patch continues the efct driver population.
> 
> This patch adds driver definitions for:
> Routines for queue creation, deletion, and configuration.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> v6:
>  Allocate wq_cpu_array based on the number of possible cpus

Reviewed-by: Daniel Wagner <dwagner@suse.de>
