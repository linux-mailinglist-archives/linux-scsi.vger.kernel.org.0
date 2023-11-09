Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5B7E673B
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Nov 2023 10:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjKIJ75 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Nov 2023 04:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIJ74 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Nov 2023 04:59:56 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604742D56
        for <linux-scsi@vger.kernel.org>; Thu,  9 Nov 2023 01:59:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso735630276.2
        for <linux-scsi@vger.kernel.org>; Thu, 09 Nov 2023 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699523993; x=1700128793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spABPCgb/AVJJnkh3vpcuJzfTnSt8idm4xU2rTGup+w=;
        b=PtXIc+rSMi1aJnVbDDuHnccYlrSo/p9RDU8cmcZzgAzDqzYtAvl0CazfaTJ/cDfDY1
         ozSDIUYbMeQt6SM/JvanvDZyIQQMm+PYEENX0Ndb6uPEPiHWFNLUvLEzZiK/Bmq9cSKK
         PQAkDvu9O8I2Uh+senuo1XW179YqFVsxlq7pSe4C5yiPyxtOH5OT7kBbafqYoj5QTr6r
         himzSaISDTVnxCFO/sVTpJsxZniOThAB34zTE7cwZ2sL97RMQ6kVYCWegHg2e0LkyBtr
         hnhyDNxY5W8wkV/CUnHWTroExqPsebHt9M0sKVs2Z4axv+uSl7EDXYk/ejT9y6OgdJbM
         TT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699523993; x=1700128793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spABPCgb/AVJJnkh3vpcuJzfTnSt8idm4xU2rTGup+w=;
        b=dN7ZyE4hmoNzNoXPRZMi8wIHLxm1jGB0+TcW+0gM9ZybkZj64Yc26hglgFiW6VP521
         yv2H3nr6YczSeXx2iavku+rQjDeyn/PMggSnL4sho7T9cKVeq31uXwyM5Pgs5/ZXuG4Z
         Nsx8y+bXzhd4AEIp1nmaOUBuszoZ/1QSip6tphfD7myIrD0M4TonQWM5qv725jkj2VrH
         /cS2aKuD5FiBNMiVygObLTx5GYqy2qM6G5JopRmFqWMXA6OTcSrHxIHwU4IBBO6Kdsn6
         B1L18kXuNKlEYEyFqWR1SM5PiuonSoNP7tZ5CizOBCvhOETfFN7iPsfMcpjX1q5sbPNJ
         vcWQ==
X-Gm-Message-State: AOJu0YxVFt6IKFvZNdWS3MQ5YrYL5y2PWfX/FWOXZoAAlmeufOB+8saX
        2sjQhpktR+AUzEAFUsULtHDL36/IlFapZqOVgzSvhA==
X-Google-Smtp-Source: AGHT+IHDhiFQRjtQFPoKUOgmxi5mMOSRabDVG3+ECBu7RWv4WOo533FYIEtzjykunUuzLGvc+lGH2PGXwpp5LuLJ768=
X-Received: by 2002:a25:54d:0:b0:da0:3b47:bf0c with SMTP id
 74-20020a25054d000000b00da03b47bf0cmr3913709ybf.20.1699523993458; Thu, 09 Nov
 2023 01:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
 <20230905052400.13935-3-quic_nitirawa@quicinc.com> <CAA8EJpr1RE5wDxM939vec8c7aaFYozXc1SxU-tT2dg4Gx4PqEg@mail.gmail.com>
 <105168e9-8b1a-9e94-c183-4cecf1d6d009@quicinc.com>
In-Reply-To: <105168e9-8b1a-9e94-c183-4cecf1d6d009@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Nov 2023 11:59:41 +0200
Message-ID: <CAA8EJproUcnAjBkD5PdE4u4ae+mASvO4m1t6T1b5czexwG35eg@mail.gmail.com>
Subject: Re: [PATCH V8 2/5] scsi: ufs: qcom: Add multiple frequency support
 for MAX_CORE_CLK_1US_CYCLES
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Nitin,

On Thu, 9 Nov 2023 at 10:14, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:

(note: top-posting is considered a bad practice)

> As per the log, I see unipro max freq is set to 300Mhz. But as per Qcom
> HPG requirement for APQ8096, max freq should be 150Mhz.
>
> In Earlier code, driver was hardcoded to configure 1US and 40ns unipro
> param for 150Mhz hence it was working. Now as per new code we read it
> from Device tree instead of hardcoding to 150 to support multiple targets.
>
> PLease can try by updating unipro min and max freq in DT to 75000000 and
> 150000000 respectively. CUrrently it is set to 150000000 and 300000000
> respectively.

The following patch didn't help:

--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2082,7 +2082,7 @@ ufshc: ufshc@624000 {
                                <0 0>,
                                <0 0>,
                                <0 0>,
-                               <150000000 300000000>,
+                               <75000000 150000000>,
                                <0 0>,
                                <0 0>,
                                <0 0>,

With this in place I got:

[    5.930424] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
control not set
[    6.448839] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
completion timeout
[    6.456720] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
control not set
[    6.993138] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
completion timeout
[    6.993443] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
control not set
[    7.504962] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
completion timeout
[    7.505270] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
control not set
[    8.016804] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
completion timeout
[    8.016838] ufshcd-qcom 624000.ufshc: link startup failed -110
[    8.016855] ufshcd-qcom 624000.ufshc: UFS Host state=0
[    8.016871] ufshcd-qcom 624000.ufshc: outstanding reqs=0x0 tasks=0x0
[    8.016888] ufshcd-qcom 624000.ufshc: saved_err=0x0, saved_uic_err=0x0
[    8.016904] ufshcd-qcom 624000.ufshc: Device power mode=1, UIC link state=0
[    8.016919] ufshcd-qcom 624000.ufshc: PM in progress=0, sys. suspended=0
[    8.016935] ufshcd-qcom 624000.ufshc: Auto BKOPS=0, Host self-block=0
[    8.016951] ufshcd-qcom 624000.ufshc: Clk gate=1
[    8.016966] ufshcd-qcom 624000.ufshc: last_hibern8_exit_tstamp at 0
us, hibern8_exit_cnt=0
[    8.016981] ufshcd-qcom 624000.ufshc: last intr at 7513416 us, last
intr status=0x400
[    8.016998] ufshcd-qcom 624000.ufshc: error handling flags=0x0,
req. abort count=0
[    8.017013] ufshcd-qcom 624000.ufshc: hba->ufs_version=0x200, Host
capabilities=0x107001f, caps=0x12cf
[    8.017029] ufshcd-qcom 624000.ufshc: quirks=0x20, dev. quirks=0x0
[    8.017045] ufshcd-qcom 624000.ufshc: clk: core_clk_src, rate: 200000000
[    8.033733] ufshcd-qcom 624000.ufshc: clk: core_clk_unipro_src,
rate: 150000000
[    8.114075] host_regs: 00000000: 0107001f 00000000 00010100 00000000
[    8.151643] host_regs: 00000010: 01000000 00010217 00000000 00000000
[    8.172260] host_regs: 00000020: 00000000 00000470 00000000 00000000
[    8.172274] host_regs: 00000030: 00000000 00000001 00000000 00000000
[    8.172286] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    8.172297] host_regs: 00000050: 00000000 00000000 00000000 00000000
[    8.172308] host_regs: 00000060: 00000000 00000000 00000000 00000000
[    8.192765] host_regs: 00000070: 00000000 00000000 00000000 00000000
[    8.192775] host_regs: 00000080: 00000000 00000000 00000000 00000000
[    8.192783] host_regs: 00000090: 00000016 00000000 00000000 00000000
[    8.192795] ufshcd-qcom 624000.ufshc: No record of pa_err
[    8.192804] ufshcd-qcom 624000.ufshc: No record of dl_err
[    8.192811] ufshcd-qcom 624000.ufshc: No record of nl_err
[    8.192817] ufshcd-qcom 624000.ufshc: No record of tl_err
[    8.192824] ufshcd-qcom 624000.ufshc: No record of dme_err
[    8.192831] ufshcd-qcom 624000.ufshc: No record of auto_hibern8_err
[    8.192838] ufshcd-qcom 624000.ufshc: No record of fatal_err
[    8.192845] ufshcd-qcom 624000.ufshc: link_startup_fail[0] =
0xffffff92 at 8016835 us
[    8.192853] ufshcd-qcom 624000.ufshc: link_startup_fail: total cnt=1
[    8.192861] ufshcd-qcom 624000.ufshc: No record of resume_fail
[    8.192867] ufshcd-qcom 624000.ufshc: No record of suspend_fail
[    8.192874] ufshcd-qcom 624000.ufshc: No record of wlun resume_fail
[    8.192880] ufshcd-qcom 624000.ufshc: No record of wlun suspend_fail
[    8.192887] ufshcd-qcom 624000.ufshc: No record of dev_reset
[    8.192894] ufshcd-qcom 624000.ufshc: No record of host_reset
[    8.192900] ufshcd-qcom 624000.ufshc: No record of task_abort
   [skipped register dump]
[    8.202797] gcc_ufs_axi_clk status stuck at 'off'
   [skipped the backtrace]
[    8.203255] ufshcd-qcom 624000.ufshc: ufshcd_setup_clocks: core_clk
prepare enable failed, -16


>
>
> Regards,
> Nitin
>
> On 11/8/2023 10:00 PM, Dmitry Baryshkov wrote:
> > On Tue, 5 Sept 2023 at 19:20, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
> >>
> >> Qualcomm UFS Controller V4 and above supports multiple unipro frequencies
> >> like 403MHz, 300MHz, 202MHz, 150 MHz, 75Mhz, 37.5 MHz. Current code
> >> supports only 150MHz and 75MHz which have performance impact due to low
> >> UFS controller frequencies.
> >>
> >> For targets which supports frequencies other than 150 MHz and 75 Mhz,
> >> needs an update of MAX_CORE_CLK_1US_CYCLES to match the configured
> >> frequency to avoid functionality issues. Add multiple frequency support
> >> for MAX_CORE_CLK_1US_CYCLES based on the frequency configured.
> >>
> >> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> >> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> >> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> >
> > This patch breaks UFS support on the APQ8096. Now the boot process
> > breaks with the following messages.
> >
> >
> > [    4.885592] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> > completion timeout
> > [    4.890996] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
> > control not set
> > [    5.424864] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> > completion timeout
> > [    5.425020] ufshcd-qcom 624000.ufshc: ufs_qcom_host_reset: reset
> > control not set
> > [    5.936918] ufshcd-qcom 624000.ufshc: uic cmd 0x16 with arg3 0x0
> > completion timeout
> > [    5.937136] ufshcd-qcom 624000.ufshc: link startup failed -110
> > [    5.943584] ufshcd-qcom 624000.ufshc: UFS Host state=0
> > [    5.949463] ufshcd-qcom 624000.ufshc: outstanding reqs=0x0 tasks=0x0
> > [    5.954594] ufshcd-qcom 624000.ufshc: saved_err=0x0, saved_uic_err=0x0
> > [    5.961106] ufshcd-qcom 624000.ufshc: Device power mode=1, UIC link state=0
> > [    5.967479] ufshcd-qcom 624000.ufshc: PM in progress=0, sys. suspended=0
> > [    5.974310] ufshcd-qcom 624000.ufshc: Auto BKOPS=0, Host self-block=0
> > [    5.981271] ufshcd-qcom 624000.ufshc: Clk gate=1
> > [    5.987541] ufshcd-qcom 624000.ufshc: last_hibern8_exit_tstamp at 0
> > us, hibern8_exit_cnt=0
> > [    5.992330] ufshcd-qcom 624000.ufshc: last intr at 5432791 us, last
> > intr status=0x400
> > [    6.000300] ufshcd-qcom 624000.ufshc: error handling flags=0x0,
> > req. abort count=0
> > [    6.008236] ufshcd-qcom 624000.ufshc: hba->ufs_version=0x200, Host
> > capabilities=0x107001f, caps=0x12cf
> > [    6.015804] ufshcd-qcom 624000.ufshc: quirks=0x20, dev. quirks=0x0
> > [    6.024942] ufshcd-qcom 624000.ufshc: clk: core_clk_src, rate: 200000000
> > [    6.031064] ufshcd-qcom 624000.ufshc: clk: core_clk_unipro_src,
> > rate: 300000000
> > [    6.037960] host_regs: 00000000: 0107001f 00000000 00010100 00000000
> > [    6.044956] host_regs: 00000010: 01000000 00010217 00000000 00000000
> > [    6.051547] host_regs: 00000020: 00000000 00000470 00000000 00000000
> > [    6.057899] host_regs: 00000030: 00000000 00000001 00000000 00000000
> > [    6.064277] host_regs: 00000040: 00000000 00000000 00000000 00000000
> > [    6.070673] host_regs: 00000050: 00000000 00000000 00000000 00000000
> > [    6.076894] host_regs: 00000060: 00000000 00000000 00000000 00000000
> > [    6.083237] host_regs: 00000070: 00000000 00000000 00000000 00000000
> > [    6.089586] host_regs: 00000080: 00000000 00000000 00000000 00000000
> > [    6.095906] host_regs: 00000090: 00000016 00000000 00000000 00000000
> > [    6.102258] ufshcd-qcom 624000.ufshc: No record of pa_err
> > [    6.108571] ufshcd-qcom 624000.ufshc: No record of dl_err
> > [    6.113865] ufshcd-qcom 624000.ufshc: No record of nl_err
> > [    6.119246] ufshcd-qcom 624000.ufshc: No record of tl_err
> > [    6.124627] ufshcd-qcom 624000.ufshc: No record of dme_err
> > [    6.130010] ufshcd-qcom 624000.ufshc: No record of auto_hibern8_err
> > [    6.135396] ufshcd-qcom 624000.ufshc: No record of fatal_err
> > [    6.141558] ufshcd-qcom 624000.ufshc: link_startup_fail[0] =
> > 0xffffff92 at 5937130 us
> > [    6.147473] ufshcd-qcom 624000.ufshc: link_startup_fail: total cnt=1
> > [    6.155187] ufshcd-qcom 624000.ufshc: No record of resume_fail
> > [    6.161608] ufshcd-qcom 624000.ufshc: No record of suspend_fail
> > [    6.167252] ufshcd-qcom 624000.ufshc: No record of wlun resume_fail
> > [    6.173070] ufshcd-qcom 624000.ufshc: No record of wlun suspend_fail
> > [    6.179322] ufshcd-qcom 624000.ufshc: No record of dev_reset
> > [    6.185915] ufshcd-qcom 624000.ufshc: No record of host_reset
> > [    6.191557] ufshcd-qcom 624000.ufshc: No record of task_abort
> > [    6.197222] HCI Vendor Specific Registers 00000000: 000000c8
> > 00000000 00000000 00000000
> > [    6.202944] HCI Vendor Specific Registers 00000010: 00000000
> > 00000000 00000000 5c5c052c
> > [    6.210755] HCI Vendor Specific Registers 00000020: 3f0113ff
> > 20020000 00000007 00000000
> > [    6.218743] HCI Vendor Specific Registers 00000030: 00000000
> > 00000000 02500000 00000000
> > [    6.226748] UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000
> > 00000000 00000000
> > [    6.234712] UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000
> > 00000000 00000000
> > [    6.242349] UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000
> > 00000000 00000000
> > [    6.249815] UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000
> > 00000000 00000000
> > [    6.257282] UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000
> > 00000000 00000000
> > [    6.264746] UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000
> > 00000000 00000000
> > [    6.272228] UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000
> > 00000000 00000000
> > [    6.279675] UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000
> > 00000000 00000000
> > [    6.287141] UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000
> > 00000000 00000000
> > [    6.294608] UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000
> > 00000000 00000000
> > [    6.302069] UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000
> > 00000000 00000000
> > [    6.309557] UFS_UFS_DBG_RD_EDTL_RAM 00000000: 00000000 a4491e48
> > fcf4caf8 46ff663f
> > [    6.317002] UFS_UFS_DBG_RD_EDTL_RAM 00000010: 3495a3c2 7be92e99
> > 2334e629 a9f5cf7a
> > [    6.324478] UFS_UFS_DBG_RD_EDTL_RAM 00000020: e0edb246 e551c5b7
> > d060df83 c84da5e6
> > [    6.331935] UFS_UFS_DBG_RD_EDTL_RAM 00000030: 59e307b2 f6855da2
> > 3d0484ee 33b4d9d9
> > [    6.339410] UFS_UFS_DBG_RD_EDTL_RAM 00000040: 4de326b3 5ba15f50
> > 50c13d42 ca1e97e5
> > [    6.346863] UFS_UFS_DBG_RD_EDTL_RAM 00000050: 4cf00e3d b54c986e
> > 0755044b e235db57
> > [    6.354346] UFS_UFS_DBG_RD_EDTL_RAM 00000060: b92c1aeb 281dc88f
> > 76ff1877 3307093a
> > [    6.361795] UFS_UFS_DBG_RD_EDTL_RAM 00000070: f8193d0a 222e4061
> > d2cc6207 1fa596f9
> > [    6.369341] UFS_UFS_DBG_RD_DESC_RAM 00000000: 00000fff 000245b9
> > 40000fff 000245d7
> > [    6.376725] UFS_UFS_DBG_RD_DESC_RAM 00000010: ad10cc60 00368847
> > 151c412f 0038a520
> > [    6.384223] UFS_UFS_DBG_RD_DESC_RAM 00000020: 0c0d244a 0036774c
> > 027721d1 00145503
> > [    6.391659] UFS_UFS_DBG_RD_DESC_RAM 00000030: ec11c082 00357203
> > 74e1d006 000d8511
> > [    6.399122] UFS_UFS_DBG_RD_DESC_RAM 00000040: c54067b1 0029bc16
> > e7e164f6 00053070
> > [    6.406588] UFS_UFS_DBG_RD_DESC_RAM 00000050: a0c0bff6 002a0367
> > 4a35b6ca 0021a240
> > [    6.414051] UFS_UFS_DBG_RD_DESC_RAM 00000060: 085b1f23 002c64ef
> > 73820a12 0010ef31
> > [    6.421515] UFS_UFS_DBG_RD_DESC_RAM 00000070: 69029047 00190510
> > 6046fb03 0026f328
> > [    6.428981] UFS_UFS_DBG_RD_DESC_RAM 00000080: 329031b4 0010e6fa
> > 17914504 00109484
> > [    6.436447] UFS_UFS_DBG_RD_DESC_RAM 00000090: 26d10045 001c14dc
> > 5503fb3d 00040c95
> > [    6.443913] UFS_UFS_DBG_RD_DESC_RAM 000000a0: 90445642 003122f0
> > f74a51e5 002c0765
> > [    6.451384] UFS_UFS_DBG_RD_DESC_RAM 000000b0: c1581085 00124fc2
> > 79137305 0024c227
> > [    6.458844] UFS_UFS_DBG_RD_DESC_RAM 000000c0: 65b22114 003b9a58
> > 61d01770 000ab182
> > [    6.466308] UFS_UFS_DBG_RD_DESC_RAM 000000d0: d4096375 00169e4c
> > 1a0477b6 00064615
> > [    6.473773] UFS_UFS_DBG_RD_DESC_RAM 000000e0: 232840aa 001c5490
> > 14cd840d 000a2944
> > [    6.481240] UFS_UFS_DBG_RD_DESC_RAM 000000f0: 8a228d09 00041b11
> > d0241490 00064e1b
> > [    6.488704] UFS_UFS_DBG_RD_DESC_RAM 00000100: 1a0f6846 000282d1
> > 06118e46 00102644
> > [    6.496169] UFS_UFS_DBG_RD_DESC_RAM 00000110: b6669e01 00052b38
> > 1720792c 000c3156
> > [    6.503634] UFS_UFS_DBG_RD_DESC_RAM 00000120: 0641cf61 000997fd
> > 7c900815 0004ad50
> > [    6.511099] UFS_UFS_DBG_RD_DESC_RAM 00000130: 1ef37280 00244c4d
> > 3bb119d0 00286f65
> > [    6.518565] UFS_UFS_DBG_RD_DESC_RAM 00000140: db9c09e5 0028c2e7
> > 5b5d1df6 0031d8dd
> > [    6.526029] UFS_UFS_DBG_RD_DESC_RAM 00000150: ca1d1166 00036152
> > d8641112 001ac503
> > [    6.533494] UFS_UFS_DBG_RD_DESC_RAM 00000160: 8d429104 0038dc61
> > cb6e324b 00311563
> > [    6.540960] UFS_UFS_DBG_RD_DESC_RAM 00000170: 4438455a 003d4061
> > 68596183 001749bf
> > [    6.548426] UFS_UFS_DBG_RD_DESC_RAM 00000180: 781e7129 00249c1f
> > 10192822 0002c85c
> > [    6.555891] UFS_UFS_DBG_RD_DESC_RAM 00000190: 16c0c0fb 000296c5
> > 3126c8d6 00345830
> > [    6.563357] UFS_UFS_DBG_RD_DESC_RAM 000001a0: 1461e741 00384181
> > 46a04712 00113eee
> > [    6.570822] UFS_UFS_DBG_RD_DESC_RAM 000001b0: 2b8332c4 00070e4e
> > 3c00b95f 002afa6c
> > [    6.578296] UFS_UFS_DBG_RD_DESC_RAM 000001c0: bc8c71c9 002b0d96
> > 0d1b0097 00061d0c
> > [    6.585752] UFS_UFS_DBG_RD_DESC_RAM 000001d0: 5da4850f 002aa5dd
> > 7cea0d59 0000bf25
> > [    6.593218] UFS_UFS_DBG_RD_DESC_RAM 000001e0: 400040a0 00080408
> > 66249825 002106cb
> > [    6.600682] UFS_UFS_DBG_RD_DESC_RAM 000001f0: e6831b0d 0010a590
> > 646e0397 00042a16
> > [    6.608198] UFS_UFS_DBG_RD_PRDT_RAM 00000000: b6500000 0000916c
> > cd401d62 00043550
> > [    6.615614] UFS_UFS_DBG_RD_PRDT_RAM 00000010: 3037914c 0005a31f
> > f5469fe9 00093259
> > [    6.623079] UFS_UFS_DBG_RD_PRDT_RAM 00000020: 00040000 00000010
> > 49470e15 000c2784
> > [    6.630543] UFS_UFS_DBG_RD_PRDT_RAM 00000030: 3e63f4c4 000c5d99
> > ff34178f 0009ebef
> > [    6.638020] UFS_UFS_DBG_RD_PRDT_RAM 00000040: e6c207f6 0002ad55
> > 58618cab 00049e17
> > [    6.645473] UFS_UFS_DBG_RD_PRDT_RAM 00000050: e175022b 000cfcfb
> > d98e1281 000dc9b2
> > [    6.652941] UFS_UFS_DBG_RD_PRDT_RAM 00000060: 10000001 00000000
> > 711494d2 000fe80b
> > [    6.660405] UFS_UFS_DBG_RD_PRDT_RAM 00000070: 4814b1d8 000a0ca1
> > 6dc32ecd 00000e54
> > [    6.667870] UFS_UFS_DBG_RD_PRDT_RAM 00000080: 00000041 00000004
> > e910c009 00018567
> > [    6.675336] UFS_UFS_DBG_RD_PRDT_RAM 00000090: 62508d4d 0004eaa8
> > 892dfb22 000cd259
> > [    6.682803] UFS_UFS_DBG_RD_PRDT_RAM 000000a0: cd20c8e2 000a55a0
> > 01816101 000f88ef
> > [    6.690267] UFS_UFS_DBG_RD_PRDT_RAM 000000b0: c811a2b7 00050746
> > 73310333 000b5b59
> > [    6.697732] UFS_UFS_DBG_RD_PRDT_RAM 000000c0: 2c4841ec 000a3517
> > b55c4bdf 00008308
> > [    6.705205] UFS_UFS_DBG_RD_PRDT_RAM 000000d0: f16cc22f 0006193d
> > f810d7ef 0005a2ef
> > [    6.712662] UFS_UFS_DBG_RD_PRDT_RAM 000000e0: 48140178 0005912e
> > 713db144 0000925e
> > [    6.720128] UFS_UFS_DBG_RD_PRDT_RAM 000000f0: 1cd0a405 000ac1a0
> > 60518a6b 000d3a4c
> > [    6.727598] UFS_DBG_RD_REG_UAWM 00000000: 00000000 00000062 00000000 0001fec0
> > [    6.735060] UFS_DBG_RD_REG_UARM 00000000: 00000000 00000001 00000011 00000001
> > [    6.742196] UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
> > [    6.749291] UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
> > [    6.756410] UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
> > [    6.763527] UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
> > [    6.770644] UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
> > [    6.777762] UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
> > [    6.784880] UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
> > [    6.791998] UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
> > [    6.799117] UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
> > [    6.806234] UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
> > [    6.813353] UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
> > [    6.820471] UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000040 00000000 00000004
> > [    6.827604] UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000001 00000000 00000004
> > [    6.834716] UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
> > [    6.841825] UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
> > [    6.848943] UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
> > [    6.856060] UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
> > [    6.863178] UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
> > [    6.870347] UFS_DBG_RD_REG_RXUC 00000060: 00000040 00000000 00000004
> > [    6.877424] UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
> > [    6.883838] UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
> > [    6.890869] UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
> > [    6.897921] UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
> > [    6.904934] UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
> > [    6.911978] UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000001
> > 00000000 00000000
> > [    6.917955] UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000
> > 00000000 00000000
> > [    6.925246] UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000
> > 00000000 00000000
> > [    6.932454] UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000
> > 00000000 00000000
> > [    6.939668] UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000
> > 00000000 00000000
> > [    6.946861] UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000
> > 00000000 00000000
> > [    6.954067] UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000
> > 00000000 00000000
> > [    6.961280] UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000
> > 00000000 00000000
> > [    6.968477] UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
> > [    6.975678] UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000001
> > 00000000 00000000
> > [    6.981497] UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000
> > 00000000 00000000
> > [    6.988527] UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
> > [    7.003383] ------------[ cut here ]------------
> > [    7.003439] gcc_ufs_axi_clk status stuck at 'off'
> > [    7.003466] WARNING: CPU: 3 PID: 60 at
> > drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x140/0x158
> > [    7.011712] Modules linked in:
> > [    7.020537] CPU: 3 PID: 60 Comm: kworker/u11:0 Tainted: G     U
> >          6.6.0-rc1-00002-gb4e13e1ae95e #1257
> > [    7.023703] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
> > [    7.033652] Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
> > [    7.039898] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    7.045371] pc : clk_branch_wait+0x140/0x158
> > [    7.052223] lr : clk_branch_wait+0x140/0x158
> > [    7.056738] sp : ffff8000833f3c30
> > [    7.060984] x29: ffff8000833f3c30 x28: ffff800081d0b200 x27: 0000000000000000
> > [    7.064218] x26: 0000000000000001 x25: ffff000081b318e8 x24: 000000019c366bfc
> > [    7.071337] x23: ffff800081611c10 x22: 0000000000000001 x21: ffff800080624180
> > [    7.078455] x20: 0000000000000000 x19: ffff800081e49738 x18: fffffffffffed120
> > [    7.085572] x17: 3030303030203030 x16: 3030303030302030 x15: 0000000000000030
> > [    7.092691] x14: 0000000000000000 x13: ffff800081d2b9f8 x12: 00000000000008e8
> > [    7.099809] x11: 00000000000002f8 x10: ffff800081d88138 x9 : ffff800081d2b9f8
> > [    7.106928] x8 : 00000000ffffefff x7 : ffff800081d839f8 x6 : 00000000000002f8
> > [    7.114046] x5 : 000000000000bff4 x4 : 40000000fffff2f8 x3 : 0000000000000000
> > [    7.121163] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000080db3200
> > [    7.128282] Call trace:
> > [    7.135372]  clk_branch_wait+0x140/0x158
> > [    7.137637]  clk_branch2_enable+0x30/0x40
> > [    7.141806]  clk_core_enable+0xd0/0x264
> > [    7.145709]  clk_enable+0x2c/0x4c
> > [    7.149353]  ufshcd_setup_clocks+0x248/0x3cc
> > [    7.152832]  ufshcd_ungate_work+0xc0/0x134
> > [    7.157170]  process_one_work+0x1ec/0x51c
> > [    7.161075]  worker_thread+0x1ec/0x3e4
> > [    7.165154]  kthread+0x120/0x124
> > [    7.168797]  ret_from_fork+0x10/0x20
> > [    7.172186] irq event stamp: 1144
> > [    7.175742] hardirqs last  enabled at (1143): [<ffff800080fa05c0>]
> > _raw_spin_unlock_irq+0x30/0x64
> > [    7.178987] hardirqs last disabled at (1144): [<ffff800080f96e08>]
> > __schedule+0x7b0/0xc00
> > [    7.187837] softirqs last  enabled at (1138): [<ffff800080090630>]
> > __do_softirq+0x430/0x4e4
> > [    7.195999] softirqs last disabled at (1133): [<ffff800080096154>]
> > ____do_softirq+0x10/0x1c
> > [    7.204158] ---[ end trace 0000000000000000 ]---
> > [    7.212642] ufshcd-qcom 624000.ufshc: ufshcd_setup_clocks: core_clk
> > prepare enable failed, -16


-- 
With best wishes
Dmitry
