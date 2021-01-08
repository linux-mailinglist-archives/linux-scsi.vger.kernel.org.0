Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD802EEA1F
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Jan 2021 01:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbhAHAEJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 19:04:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:55514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbhAHAEJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 19:04:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610064202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i4evg2LHWlq6piKSCKYVQ0YNBV8XIgpW9lXyKxh8Pg=;
        b=HEvuDdjtp9qWSGmzfdxEhJxkaUWaTbG7OUkvlbLrHaRmRyiCIYUO1t+P5n9/LxQ0ZmYGj4
        0BtZWh8mZfF8DOqdC8fldZvZqgNh9DSTCcxBQjintTpcDsOwFC+KOO+KSlBT94Rf7/fDd4
        7mTw+o+XbOs3gAo0vBxcHEMWxqycOYU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0B2BACAF;
        Fri,  8 Jan 2021 00:03:22 +0000 (UTC)
Message-ID: <16249db73f0e36b4fc2ed971069080eff8a48186.camel@suse.com>
Subject: Re: [PATCH V3 19/25] smartpqi: add phy id support for the physical
 drives
From:   Martin Wilck <mwilck@suse.com>
To:     Don Brace <don.brace@microchip.com>, Kevin.Barnett@microchip.com,
        scott.teel@microchip.com, Justin.Lindley@microchip.com,
        scott.benesh@microchip.com, gerry.morong@microchip.com,
        mahesh.rajashekhara@microchip.com, hch@infradead.org,
        jejb@linux.vnet.ibm.com, joseph.szczypek@hpe.com, POSWALD@suse.com
Cc:     linux-scsi@vger.kernel.org
Date:   Fri, 08 Jan 2021 01:03:21 +0100
In-Reply-To: <160763257085.26927.11572432608178521227.stgit@brunhilda>
References: <160763241302.26927.17487238067261230799.stgit@brunhilda>
         <160763257085.26927.11572432608178521227.stgit@brunhilda>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-12-10 at 14:36 -0600, Don Brace wrote:
> From: Murthy Bhat <Murthy.Bhat@microchip.com>
> 
> * Display topology using PHY numbers.
> * PHY(both local and remote) numbers corresponding to physical drives
>     are read from BMIC_IDENTIFY_PHYSICAL_DEVICE.
> 
> Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
> Reviewed-by: Scott Teel <scott.teel@microchip.com>
> Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
> Signed-off-by: Murthy Bhat <Murthy.Bhat@microchip.com>
> Signed-off-by: Don Brace <don.brace@microchip.com>

Reviewed-by: Martin Wilck <mwilck@suse.com>


