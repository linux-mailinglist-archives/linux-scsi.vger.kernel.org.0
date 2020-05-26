Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25F419E765
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Apr 2020 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDDTdm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 4 Apr 2020 15:33:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38667 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDTdl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 4 Apr 2020 15:33:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so10467932ljg.5;
        Sat, 04 Apr 2020 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4BEcKBM854EHRMSKSj1v3PrUiNMQfzD93zf2eqZZW/s=;
        b=nyxaeOuyPwFenTed8gTtBXUlljPovb6+sQ9vLs7bvDrFjwvPuoTVepfOrznRhamr4C
         wNwTDsMmLm+HyruZXRQfHi/uE4+TCDavaZPeILfulcyogfVj7lWy4drIFP6fjoTSEPkP
         G+9a1Q5GmNBUL0si0eMrteNij6iFUlAmjfVhtknu0F1qT0LqvsT3z8KWI61DuNESjU9d
         WLcC48lScoOa9LSQEpVe3f9IfIvrqDvwLWjCDFAsphU9m+yAu6Ghy5370/n3oxBsnHmW
         +amSAYbtEzyYx+o/9VZBKgDVoqydAYqYFcYy3Vh2Kpj6EH9FEaFC4m3Fq77R7UEfKdCm
         H4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4BEcKBM854EHRMSKSj1v3PrUiNMQfzD93zf2eqZZW/s=;
        b=YYDEG00bGuWsY/dHCgCMju4w5zpOD6v597pB4gKVQruiFHCVx2IiYG0lcrOFCkBtT9
         t8KPovygYEhFOHkx8DhrtSXMrgy2/ZpE9mUYi8IBhzjycGrHJL8AYGGXU4OKec0AczDP
         7MkzAAeuu6S/souTSkVsvrUX1AqfaqX/yU80lfvuWeuUhSpmo99GLt6YTkBR9dNGxL4E
         igFdrJIUY/tsMg7gduLJb3/Qp6OP0iWAs1318Tdn7mnf3io+23olRIkM0MScbVJptRwH
         1C0wkUfLOU2UwZkxwRKDjTT9tFctRUxnbSaq+D2KBUguuDJg6Xjq6lk1/TZg8wkjPda4
         /jog==
X-Gm-Message-State: AGi0PubfKE+RlFF9BDuF05dW0KLz+Lu+AYkiVa+lkV6kfX98ZLiIyKtk
        YFh42GIfEbmbCUdhDg2vNMk=
X-Google-Smtp-Source: APiQypI46R59B0fPH0tDt7zirMg6uIu9BgCDmR65KJ6W7oyLUAS3UTwZshkiz1kOuOH7lrt90VANQw==
X-Received: by 2002:a05:651c:201d:: with SMTP id s29mr8464429ljo.214.1586028815892;
        Sat, 04 Apr 2020 12:33:35 -0700 (PDT)
Received: from pablo-laptop ([2a02:a315:5445:5300:95b9:c293:40ef:8bdd])
        by smtp.googlemail.com with ESMTPSA id s10sm7536789ljp.87.2020.04.04.12.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 12:33:34 -0700 (PDT)
Message-ID: <17aa7c13a0f5a183158829e9b9af85537a740846.camel@gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: Add node for ufs exynos7
From:   =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     krzk@kernel.org, avri.altman@wdc.com, martin.petersen@oracle.com,
        kwmad.kim@samsung.com, stanley.chu@mediatek.com,
        cang@codeaurora.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 04 Apr 2020 21:33:33 +0200
In-Reply-To: <000001d60aad$05e7b6e0$11b724a0$@samsung.com>
References: <20200327170638.17670-1-alim.akhtar@samsung.com>
         <CGME20200327171423epcas5p485d227f19e45999ad9b42b21d2864e4a@epcas5p4.samsung.com>
         <20200327170638.17670-6-alim.akhtar@samsung.com>
         <ac67cfc3736cf50c716b823a59af878d59b7198f.camel@gmail.com>
         <000801d60516$823fd890$86bf89b0$@samsung.com>
         <838a17416b4ed59903ae153e09842ac62584616f.camel@gmail.com>
         <002e01d605df$af658440$0e308cc0$@samsung.com>
         <1182150aff8140a82af17979a09c81676c719e2f.camel@gmail.com>
         <000001d60aad$05e7b6e0$11b724a0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2020-04-04 at 23:45 +0530, Alim Akhtar wrote:
Hi Alim,
> Hi Pawel,
> 
> > -----Original Message-----
> > From: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > Sent: 03 April 2020 22:22
> > To: Alim Akhtar <alim.akhtar@samsung.com>; robh+dt@kernel.org;
> > devicetree@vger.kernel.org; linux-scsi@vger.kernel.org
> > Cc: krzk@kernel.org; avri.altman@wdc.com; martin.petersen@oracle.com;
> > kwmad.kim@samsung.com; stanley.chu@mediatek.com;
> > cang@codeaurora.org; linux-samsung-soc@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 5/5] arm64: dts: Add node for ufs exynos7
> > 
> > Hi Alim
> > 
> > Looking at vendor sources, my device is using the same gpios for
> > urfs_rst_n and ufs_refclk_out like Espresso (with one difference -
> > ufs_rst_n shouldn't be pulled up).
> > 
> > About regulators (it would be easier if dts would have all regulators).
> > It's also using s2mps15 as Espresso, but it vendor dts had only 8 (of
> > 10 possible bucks, one missing was for UFS) and 14 ldos (of 27
> > possible), where almost all rails are connected to something.
> > 
> > I'm wondering how it's working on Espresso, because when adding correct
> > regulators for ufs (vccq = buck10 from s2mps15, always enabled for
> > testing plus vccq2 and vccq = two regulators enabled by one gpio,
> > enabled at boot by firmware), ufs wasn't still working because it was
> > then failing at defer probe (s2mps15 was probed after ufs)
> > 
> > [    0.962482] exynos-ufshc 15570000.ufs: ufshcd_get_vreg: vccq get
> > failed, err=-517
> > 
> As I said, this is very specific to the board, on Espresso we have LDO12 connected to UFS_RESETn.
> Either make all of them as always-on, or just disabled s2mps15 
> (default voltage supply should be ok, unless bootloader on your board does have messed too much with PMIC)
>  
> > After that boot would just stop/hang.
> > 
> > After making a "dirty fix" by making s2mps15 regulator driver use
> > subsys_initcall (like in vendor sources) and ufs late_initcall (to give
> > it more time to setup and get it working and solve it later),
> > i had to mark following clocks as CLK_IGNORE_UNUSED to be able to bring
> > link up (it replicates setting done by vendor kernel, which enables
> > them on boot):
> > - "phyclk_ufs20_rx1_symbol_user"
> > - "phyclk_ufs20_rx0_symbol_user"
> > - "phyclk_ufs20_tx0_symbol_user"
> > 
> Coming to these clocks, all these are supplied by default, my best guess is since you are using an actual product (S6 edge), they might have optimized for power saving 
> And most likely all clock might be  gated initially. In my case all are set to default.
> I have attached a small change in the exynos7 dts and phy driver clock handling, please try this attached patch and let me know if this helps in removing some of your hacks.
> In the later SoCs these clocks are not in this form, so I didn't included in my current patch set, If this works for your, will add as an optional for exynos7/7420.
> I also assume you are using clk-exynos7.c and my posted ufs driver.
Yes, i'm using clk-exynos7 (and other exynos7 drivers/dts/etc).
It would be great if someone could say how exynos7 and exynos7420 are
similar. For now it looks like that only difference is that exynos7 has
only 4 cores (a57) where 7420 has 4xa53 + 4xa57.
It would be very valuable information for me so i could know how much i
could reuse my device.
> 
> > Now it's able to bring both device and link, but it fails at
> > ufshcd_uic_change_pwr_mode.
> > 
> Can you please use the exact ufs and ufs-phy device node as in my patch?
With Your patch + removed my changes to clocks (removed fix for wrong
clock order in dts + removed CLK_IGNORE_UNUSED from symbol clocks in
clk-exynos7) it's finally able to detect my UFS device!! 

(but of fails later...with constant error spam in kernel log).

[    1.383481] exynos-ufshc 15570000.ufs: ufshcd_populate_vreg: Unable
to find vdd-hba-supply regulator, assuming enabled
[    1.390060] exynos-ufshc 15570000.ufs: ufshcd_populate_vreg: unable
to find vcc-max-microamp
[    1.398465] exynos-ufshc 15570000.ufs: ufshcd_populate_vreg: unable
to find vccq-max-microamp
[    1.406968] exynos-ufshc 15570000.ufs: ufshcd_populate_vreg: unable
to find vccq2-max-microamp
[    1.415569] exynos-ufshc 15570000.ufs: ufshcd_init_clocks: clk:
core_clk, rate: 100000000
[    1.423715] exynos-ufshc 15570000.ufs: ufshcd_init_clocks: clk:
sclk_unipro_main, rate: 167000000
[    1.432569] exynos-ufshc 15570000.ufs: __ufshcd_setup_clocks: clk:
core_clk enabled
[    1.440205] exynos-ufshc 15570000.ufs: __ufshcd_setup_clocks: clk:
sclk_unipro_main enabled
[    1.449613] scsi host0: ufshcd
[    1.452179] samsung-ufs-phy 15571800.ufs-phy: MPHY ref_clk_rate =
26000000
[    1.458448] samsung-ufs-phy 15571800.ufs-phy: MPHY
ref_parent_clk_rate = 26000000
[    1.487288] exynos-ufshc 15570000.ufs: ufshcd_print_pwr_info:[RX,
TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate =
0
[    2.025569] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd041 val
0x1fff error code 1
[    2.025715] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd041 val
0x1fff failed 0 retries
[    2.025880] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd042 val
0xffff error code 1
[    2.027354] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd042 val
0xffff failed 0 retries
[    2.035583] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd043 val
0x7fff error code 1
[    2.043465] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd043 val
0x7fff failed 0 retries
[    2.054049] exynos-ufshc 15570000.ufs: Power mode change 0 : Fast
series_B G_2 L_2
[    2.059261] exynos-ufshc 15570000.ufs: ufshcd_print_pwr_info:[RX,
TX]: gear=[2, 2], lane[2, 2], pwr[FAST MODE, FAST MODE], rate = 2
[    2.071307] exynos-ufshc 15570000.ufs: ufshcd_init_icc_levels:
setting icc_level 0x0
[    2.081624] exynos-ufshc 15570000.ufs: ufshcd_set_queue_depth:
activate tcq with queue depth 1
[    2.087576] scsi 0:0:0:49488: scsi_add_lun: correcting incorrect
peripheral device type 0x0 for W-LUN 0x            c150hN
[    2.098400] scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUBG4G1BD-
E0B1  0200 PQ: 0 ANSI: 6
[    2.107585] exynos-ufshc 15570000.ufs: ufshcd_set_queue_depth:
activate tcq with queue depth 16
[    2.115588] scsi 0:0:0:49476: scsi_add_lun: correcting incorrect
peripheral device type 0x0 for W-LUN 0x            c144hN
[    2.126519] scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUBG4G1BD-
E0B1  0200 PQ: 0 ANSI: 6
[    2.135534] exynos-ufshc 15570000.ufs: ufshcd_set_queue_depth:
activate tcq with queue depth 1
[    2.143612] scsi 0:0:0:49456: scsi_add_lun: correcting incorrect
peripheral device type 0x0 for W-LUN 0x            c130hN
[    2.154543] scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUBG4G1BD-
E0B1  0200 PQ: 0 ANSI: 6
[    2.163597] exynos-ufshc 15570000.ufs: ufshcd_set_queue_depth:
activate tcq with queue depth 16
[    2.171721] scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUBG4G1BD-
E0B1  0200 PQ: 0 ANSI: 6
[    2.180352] exynos-ufshc 15570000.ufs: OCS error from controller = 7
for tag 0
[    2.186921] host_regs: 00000000: 0383ff0f 00000000 00000200 00000000
[    2.193230] host_regs: 00000010: 00000101 00007fce 00000c96 00000000
[    2.199565] host_regs: 00000020: 00000000 00030e75 00000000 00000000
[    2.205899] host_regs: 00000030: 0000010f 00000000 80000010 00000000
[    2.212234] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    2.218568] host_regs: 00000050: f8d64000 00000000 00000000 00000000
[    2.224903] host_regs: 00000060: 00000001 00000000 00000000 00000000
[    2.231237] host_regs: 00000070: f8da2000 00000000 00000000 00000000
[    2.237572] host_regs: 00000080: 00000001 00000000 00000000 00000000
[    2.243907] host_regs: 00000090: 00000002 95190000 00000000 00000000
[    2.250242] exynos-ufshc 15570000.ufs: hba->ufs_version = 0x200,
hba->capabilities = 0x383ff0f

Full bootlog 
https://gist.github.com/PabloPL/0bcb24492f4ab6e9703c2a4ea20ceb18
kernel source: https://github.com/PabloPL/linux/tree/ufs-mainline
dts file: exynos7-zeroflt.dts (it should be zerolt, but will be
fixed/changed later).

Thanks
> 
> > [    1.411547] exynos-ufshc 15570000.ufs: ufshcd_init_clocks: clk:
> > core_clk, rate: 100000000
> > [    1.419698] exynos-ufshc 15570000.ufs: ufshcd_init_clocks: clk:
> > sclk_unipro_main, rate: 167000000
> > [    1.428550] exynos-ufshc 15570000.ufs: __ufshcd_setup_clocks: clk:
> > core_clk enabled
> > [    1.436200] exynos-ufshc 15570000.ufs: __ufshcd_setup_clocks: clk:
> > sclk_unipro_main enabled
> > [    1.445704] scsi host0: ufshcd
> > [    1.465684] exynos-ufshc 15570000.ufs: ufshcd_print_pwr_info:[RX,
> > TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate
> > =
> > 0
> > [    2.023699] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd041 val
> > 0x1fff error code 1
> > [    2.023846] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd041 val
> > 0x1fff failed 0 retries
> > [    2.024025] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd042 val
> > 0xffff error code 1
> > [    2.025457] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd042 val
> > 0xffff failed 0 retries
> > [    2.033777] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd043 val
> > 0x7fff error code 1
> > [    2.041607] exynos-ufshc 15570000.ufs: dme-set: attr-id 0xd043 val
> > 0x7fff failed 0 retries
> > [    2.067809] exynos-ufshc 15570000.ufs: pwr ctrl cmd 0x2 failed, host
> > upmcrs:0x5
> > [    2.067953] exynos-ufshc 15570000.ufs: UFS Host state=0
> > [    2.068056] exynos-ufshc 15570000.ufs: outstanding reqs=0x0
> > tasks=0x0
> > [    2.068759] exynos-ufshc 15570000.ufs: saved_err=0x0,
> > saved_uic_err=0x0
> > [    2.075368] exynos-ufshc 15570000.ufs: Device power mode=1, UIC link
> > state=1
> > [    2.082392] exynos-ufshc 15570000.ufs: PM in progress=0, sys.
> > suspended=0
> > [    2.089158] exynos-ufshc 15570000.ufs: Auto BKOPS=0, Host self-
> > block=0
> > [    2.095667] exynos-ufshc 15570000.ufs: Clk gate=1
> > [    2.100354] exynos-ufshc 15570000.ufs: error handling flags=0x0,
> > req. abort count=0
> > [    2.107987] exynos-ufshc 15570000.ufs: Host capabilities=0x383ff0f,
> > caps=0x0
> > [    2.115018] exynos-ufshc 15570000.ufs: quirks=0x780, dev.
> > quirks=0xc4
> > [    2.121443] exynos-ufshc 15570000.ufs: ufshcd_print_pwr_info:[RX,
> > TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate
> > =
> > 0
> > [    2.133960] host_regs: 00000000: 0383ff0f 00000000 00000200 00000000
> > [    2.140268] host_regs: 00000010: 00000101 00007fce 00000000 00000000
> > [    2.146604] host_regs: 00000020: 00000000 00030a75 00000000 00000000
> > [    2.152940] host_regs: 00000030: 0000050f 00000000 80000010 00000000
> > [    2.159271] host_regs: 00000040: 00000000 00000000 00000000 00000000
> > [    2.165609] host_regs: 00000050: f9587000 00000000 00000000 00000000
> > [    2.171944] host_regs: 00000060: 00000001 00000000 00000000 00000000
> > [    2.178278] host_regs: 00000070: f958a000 00000000 00000000 00000000
> > [    2.184609] host_regs: 00000080: 00000001 00000000 00000000 00000000
> > [    2.190945] host_regs: 00000090: 00000002 15710000 00000000 00000000
> > [    2.197282] exynos-ufshc 15570000.ufs: hba->ufs_version = 0x200,
> > hba->capabilities = 0x383ff0f
> > [    2.205869] exynos-ufshc 15570000.ufs: hba->outstanding_reqs = 0x0,
> > hba->outstanding_tasks = 0x0
> > [    2.214636] exynos-ufshc 15570000.ufs: last_hibern8_exit_tstamp at 0
> > us, hibern8_exit_cnt = 0
> > [    2.223141] exynos-ufshc 15570000.ufs: No record of pa_err
> > [    2.228606] exynos-ufshc 15570000.ufs: No record of dl_err
> > [    2.234071] exynos-ufshc 15570000.ufs: No record of nl_err
> > [    2.239540] exynos-ufshc 15570000.ufs: No record of tl_err
> > [    2.245007] exynos-ufshc 15570000.ufs: No record of dme_err
> > [    2.250558] exynos-ufshc 15570000.ufs: No record of auto_hibern8_err
> > [    2.256895] exynos-ufshc 15570000.ufs: No record of fatal_err
> > [    2.262624] exynos-ufshc 15570000.ufs: No record of
> > link_startup_fail
> > [    2.269044] exynos-ufshc 15570000.ufs: No record of resume_fail
> > [    2.274942] exynos-ufshc 15570000.ufs: No record of suspend_fail
> > [    2.280931] exynos-ufshc 15570000.ufs: No record of dev_reset
> > [    2.286659] exynos-ufshc 15570000.ufs: No record of host_reset
> > [    2.292475] exynos-ufshc 15570000.ufs: No record of task_abort
> > [    2.298290] exynos-ufshc 15570000.ufs: ufshcd_change_power_mode:
> > power mode change failed 5
> > [    2.306619] exynos-ufshc 15570000.ufs: ufshcd_probe_hba: Failed
> > setting power mode, err = 5
> > [    2.315144] exynos-ufshc 15570000.ufs: __ufshcd_setup_clocks: clk:
> > core_clk disabled
> > 
> > And here boot would just stop/hang.
> > 
> > Thanks for all hints.
> > 
> > > 
> > > > > > Also looking at clk-exynos7 driver seems to confirm this.
> > > > > > 
> > > > > > > +		};
> > > > > > > +
> > > > > > >  		usbdrd_phy: phy@15500000 {
> > > > > > >  			compatible = "samsung,exynos7-usbdrd-phy";
> > > > > > >  			reg = <0x15500000 0x100>;
> 
> 

