Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147705906C5
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Aug 2022 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiHKTA3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Aug 2022 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiHKTA0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Aug 2022 15:00:26 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901B433A18
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660244423; x=1691780423;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Uzj3YwW6ocVHk+CwQQzQFprEylxVDouB0qPIFdDgEgc=;
  b=Ka41FiLN9P8f1UhaecFYudPhWIVqTkLFVwye8aAfN7CS4ivpyJKiGlZH
   uypSZVYp6b1XzU7dQ0AMT2+/c52tY/mlnrSH+mJCJwVVUD/wrajXL1xy5
   y1og7842rqbPN456EjC0lIbK8SHAyD0GoZ+ern5oFEkdV0tE6srV+Juht
   CWH/mURcRPMPAQTdktNGIA95qGK0Eb+fjDSNJqsWZ+aHUfOy/pQZ5VkbE
   Za8FpwQw+x9F7/uoevne6nBELwLaBxNdrzIc7JHULrSqjGP7/tDXVETAk
   933X7Ll19uwOQlI/yx/XJA9F3u4gsolSG0jm16TtEMoVPjP1+nLAdGXcw
   A==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="209026061"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 03:00:21 +0800
IronPort-SDR: d2aFZEmOI9vYCSjCx/et6lkMNoiIDLWi0FOopaXe1EdOTse6QBScqSXcM/heW80m2aWXMM5yx+
 OUnqJq0/97pM++dOrZcnC9l5GPP8PMgi3vB9QT3O1tXiNqturCMo5v/Yq0eb2K71D0skLznBT4
 UUapx//EV/6pzMNjaLLXHpJHrnmpaQKysKyZBBkN5/KeqYnfrWxBRKE2dBd33t+xBCpYpEmSII
 S/fuajia4ErQRuX6o3army8/ezVU8xkTlhO5bFOI7EreODYrPhkHbiU2NPmT/3WNY6/2xrcLFX
 IDCQBPJO3FOeBg3VXXuJsyxC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 11:15:55 -0700
IronPort-SDR: YnNWiddr/tMAQeTgEXwkbITCkQXihbwwcEfKIK+f44G1pW8VLWWKnMZexcwPy7OnhZJ1EzZtyw
 SXEGvoulbqptala7zW00Ua758sMN62ES5S3WHBem2P1fXA6dIHW1KgOVIwg0fydbxSR3s0dZeo
 rZe8lSr9H72FXF0zd7bONMwcbyfWurZh9DaD6/FhO7kDB6S8xkVMB+TFxi/Fpc3m2zblN96Hdx
 +PCqPUW8bTGGEjbYkGzWaJzu+tQdGTx3b2tN7ll7O6bTeq7K5xrPStzwgAMDduokXJ40bsT4dl
 Wts=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 12:00:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3bjJ6h1rz1Rwqy
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 12:00:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660244420; x=1662836421; bh=Uzj3YwW6ocVHk+CwQQzQFprEylxVDouB0qP
        IFdDgEgc=; b=htalaxQZLU6n+xQ53+fYXwM44z2mD9rqJz5xkVjM72dgu3Y8YUv
        VS72N5ctoI2vmMnq7ppssxEXAvf2TZ1pQLsEjJw48nTqJzEFRVfiopqILahyJ3/E
        FcKrtNeQFyHJpZmIJRb6wJUrv5c6Mc1W0YpuGT6OKb/2wszJL7zgArsOx48+Hfsp
        gqGIosaPXIlU7ZniOBjtgWEFln0Gp/l9hCXMV9KngBYPyd5B4NGJEBQbPpqaoSXS
        bX1ke+4dp9AUK6GjlXsyHqHM8DFE+UcurGOKZcu7tY0sfGoOj3Gk0t+mjLShNeKu
        1CS4dmrF9Ii5TrIHj+GYSet3ft/6WzmGYUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3_PednzjF40k for <linux-scsi@vger.kernel.org>;
        Thu, 11 Aug 2022 12:00:20 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3bjH4Nw6z1RtVk;
        Thu, 11 Aug 2022 12:00:19 -0700 (PDT)
Message-ID: <b262981b-9925-5812-2b5d-0d4a2a16e97d@opensource.wdc.com>
Date:   Thu, 11 Aug 2022 12:00:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com, chenxiang66@hisilicon.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
 <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022/08/11 11:54, Damien Le Moal wrote:
> On 2022/07/22 4:24, John Garry wrote:
>> As reported in [0], the pm8001 driver NCQ error handling more or less
>> duplicates what libata does in link error handling, as follows:
>> - abort all commands
>> - do autopsy with read log ext 10 command
>> - reset the target to recover
>>
>> Indeed for the hisi_sas driver we want to add similar handling for NCQ
>> errors.
>>
>> This series add a new libsas API - sas_ata_link_abort() - to handle host
>> NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
>> mentioned in the pm8001 changeover patch, I would prefer a better place to
>> locate the SATA ABORT command (rather that nexus reset callback).
>>
>> I would appreciate some testing of the pm8001 change as the read log ext10
>> command mostly hangs on my arm64 machine - these arm64 hangs are a known
>> issue.
> 
> I applied this series on top of the current Linus tree and ran some tests: a
> bunch of fio runs and also ran libzbc test suites on a SATA SMR drive as that
> generates many command failures. No problems detected, the tests all pass.
> FYI, messages for failed commands look like this:
> 
> pm80xx0:: mpi_sata_event 2685: SATA EVENT 0x23
> sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> sas: sas_scsi_find_task: aborting task 0x00000000ba62a907
> pm80xx0:: mpi_sata_completion 2292: task null, freeing CCB tag 2
> sas: sas_scsi_find_task: task 0x00000000ba62a907 is aborted
> sas: sas_eh_handle_sas_errors: task 0x00000000ba62a907 is aborted
> ata21.00: exception Emask 0x0 SAct 0x20000000 SErr 0x0 action 0x0
> ata21.00: failed command: WRITE FPDMA QUEUED
> ata21.00: cmd 61/02:00:ff:ff:ea/00:00:02:00:00/40 tag 29 ncq dma 8192 out
> res 43/04:02:ff:ff:ea/00:00:02:00:00/00 Emask 0x400 (NCQ error) <F>
> ata21.00: status: { DRDY SENSE ERR }
> ata21.00: error: { ABRT }
> ata21.00: configured for UDMA/133
> ata21: EH complete
> sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 tries: 1
> 
> Seems all good to me.

Forgot to mention: tested with pm80xx driver.

> 
>>
>> Finally with these changes we can make the libsas task alloc/free APIs
>> private, which they should always have been.
>>
>> Based on v5.19-rc6
>>
>> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
>>
>> John Garry (5):
>>   scsi: pm8001: Modify task abort handling for SATA task
>>   scsi: libsas: Add sas_ata_link_abort()
>>   scsi: pm8001: Use sas_ata_link_abort() to handle NCQ errors
>>   scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>>   scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
>>
>> Xingui Yang (1):
>>   scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
>>
>>  drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>>  drivers/scsi/libsas/sas_ata.c          |  10 ++
>>  drivers/scsi/libsas/sas_init.c         |   3 -
>>  drivers/scsi/libsas/sas_internal.h     |   4 +
>>  drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
>>  drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
>>  drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
>>  drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
>>  include/scsi/libsas.h                  |   4 -
>>  include/scsi/sas_ata.h                 |   5 +
>>  11 files changed, 132 insertions(+), 313 deletions(-)
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research
