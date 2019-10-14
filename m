Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081B6D6926
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Oct 2019 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbfJNSJu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Oct 2019 14:09:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46752 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbfJNSJt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Oct 2019 14:09:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so14555409oth.13;
        Mon, 14 Oct 2019 11:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63o5PcHaDJUmkAXGwWJp9biK2A6MeDJVIPuekW55gGQ=;
        b=ZoLHEj/XiRbtX1bniFmHdb03RnIj+usQvsJSM49CWvFYe70r0UrCYnNQz3VXlEZuNc
         SoIWqHUCJfRX6cNGAt6scfnaH5OClWp3TtTU9LOKuu0bGjJICMhcTvUu53g8NYdVRlk0
         aE3ApLuWHHS5QP3bbTjgfntvGbmzbCkgf6HOKuTlN7NPUwoyFl2CfjiZpWRAYGjPB0tU
         q8RuycaDWy562F1hxeI418rLUdN5EEVdGD8SbNvOWNc84toeLOdWwe7FUgo7OQh5ZnJD
         cuULo/eIuG0jEjeqiPcIvoZMQVrm3Oc6gJ9jLo5jQX/LQRCnr2mtVPDw7xoepNMbIf4i
         4Opw==
X-Gm-Message-State: APjAAAXGTMqYx35kbv0UwUX5Nzntvh4Kcsgyb6yNBUvJejyCyOZUlR70
        S9XMUlJgAiYr4MS7Apah0w==
X-Google-Smtp-Source: APXvYqyr2RmoUKIYmcnbAUSCFIfE6p1qnvVMPgpyHtdQ2kdChxIgS9ZhVEHvmg5e7YvJGI9H9K+GDA==
X-Received: by 2002:a9d:684c:: with SMTP id c12mr26129585oto.341.1571076588764;
        Mon, 14 Oct 2019 11:09:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm5884056otc.52.2019.10.14.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 11:09:48 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:09:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, jejb@linux.ibm.com,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Janek Kotas <jank@cadence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>, nsekhar@ti.com
Subject: Re: [PATCH v2 1/2] dt-bindings: ufs: ti,j721e-ufs.yaml: Add binding
 for TI UFS wrapper
Message-ID: <20191014180947.GA881@bogus>
References: <20191010083357.28982-1-vigneshr@ti.com>
 <20191010083357.28982-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010083357.28982-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 10 Oct 2019 14:03:56 +0530, Vignesh Raghavendra wrote:
> Add binding documentation of TI wrapper for Cadence UFS Controller.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> v2:
> Define Cadence UFS controller as child node of the wrapper as suggested
> by Rob H
> 
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
